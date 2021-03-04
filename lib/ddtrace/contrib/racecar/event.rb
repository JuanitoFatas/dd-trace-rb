require 'ddtrace/contrib/analytics'
require 'ddtrace/contrib/active_support/notifications/event'
require 'ddtrace/contrib/racecar/ext'
require 'ddtrace/ext/integration'

module Datadog
  module Contrib
    module Racecar
      # Defines basic behaviors for an ActiveRecord event.
      module Event
        def self.included(base)
          base.send(:include, ActiveSupport::Notifications::Event)
          base.send(:extend, ClassMethods)
        end

        # Class methods for Racecar events.
        # Note, they share the same process method and before_trace method.
        module ClassMethods
          def subscription(*args)
            super.tap do |subscription|
              subscription.before_trace { Contrib::Support.ensure_finished_context!(configuration[:tracer], Ext::APP) }
            end
          end

          def span_options
            { service: configuration[:service_name] }
          end

          def tracer
            -> { configuration[:tracer] }
          end

          def configuration
            Datadog.configuration[:racecar]
          end

          def process(span, event, _id, payload)
            span.service = configuration[:service_name]
            span.resource = payload[:consumer_class]

            # Tag as an external peer service
            span.set_tag(Datadog::Ext::Integration::TAG_PEER_SERVICE, span.service)

            # Set analytics sample rate
            if Contrib::Analytics.enabled?(configuration[:analytics_enabled])
              Contrib::Analytics.set_sample_rate(span, configuration[:analytics_sample_rate])
            end

            # Measure service stats
            Contrib::Analytics.set_measured(span)

            span.set_tag(Ext::TAG_TOPIC, payload[:topic])
            span.set_tag(Ext::TAG_CONSUMER, payload[:consumer_class])
            span.set_tag(Ext::TAG_PARTITION, payload[:partition])
            span.set_tag(Ext::TAG_OFFSET, payload[:offset]) if payload.key?(:offset)
            span.set_tag(Ext::TAG_FIRST_OFFSET, payload[:first_offset]) if payload.key?(:first_offset)
            span.set_tag(Ext::TAG_MESSAGE_COUNT, payload[:message_count]) if payload.key?(:message_count)
            span.set_error(payload[:exception_object]) if payload[:exception_object]
          end
        end
      end
    end
  end
end
