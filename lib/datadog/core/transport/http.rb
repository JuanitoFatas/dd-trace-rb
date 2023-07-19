# frozen_string_literal: true

require 'uri'

require_relative '../environment/container'
require_relative '../environment/ext'
require_relative '../../../ddtrace/transport/ext'
require_relative '../../../ddtrace/transport/http/adapters/net'
require_relative '../../../ddtrace/transport/http/adapters/test'
require_relative '../../../ddtrace/transport/http/adapters/unix_socket'

# TODO: Improve negotiation to allow per endpoint selection
#
# Since endpoint negotiation happens at the `API::Spec` level there can not be
# a mix of enpoints at various versions or versionless without describing all
# the possible combinations as specs. See http/api.
#
# Below should be:
# require_relative '../../../ddtrace/transport/http/api'
require_relative 'http/api'

# TODO: Decouple transport/http/builder
#
# See http/builder
#
# Below should be:
# require_relative '../../../ddtrace/transport/http/builder'
require_relative 'http/builder'

# TODO: Decouple transport/http
#
# Because a new transport is required for every (API, Client, Transport)
# triplet and endpoints cannot be negotiated independently, there can not be a
# single `default` transport, but only endpoint-specific ones.

module Datadog
  module Core
    module Transport
      # Namespace for HTTP transport components
      module HTTP
        # NOTE: Due to... legacy reasons... This class likes having a default `AgentSettings` instance to fall back to.
        # Because we generate this instance with an empty instance of `Settings`, the resulting `AgentSettings` below
        # represents only settings specified via environment variables + the usual defaults.
        #
        # DO NOT USE THIS IN NEW CODE, as it ignores any settings specified by users via `Datadog.configure`.
        # DO_NOT_USE_ENVIRONMENT_AGENT_SETTINGS = Datadog::Core::Configuration::AgentSettingsResolver.call(
        #   Datadog::Core::Configuration::Settings.new,
        #   logger: nil,
        # )

        module_function

        # Builds a new Transport::HTTP::Client
        def new(klass, &block)
          Builder.new(&block).to_transport(klass)
        end

        # Builds a new Transport::HTTP::Client with default settings
        # Pass a block to override any settings.
        def root(
          agent_settings: nil,
          **options
        )
          new(Transport::Negotiation::Transport) do |transport|
            unless agent_settings
              agent_settings = Datadog::Core::Configuration::AgentSettingsResolver.call(Datadog.configuration, logger: Datadog.logger)
            end
            transport.adapter(agent_settings)
            transport.headers(default_headers)

            apis = API.defaults

            transport.api API::ROOT, apis[API::ROOT]

            # Apply any settings given by options
            unless options.empty?
              transport.default_api = options[:api_version] if options.key?(:api_version)
              transport.headers options[:headers] if options.key?(:headers)
            end

            if agent_settings.deprecated_for_removal_transport_configuration_proc
              agent_settings.deprecated_for_removal_transport_configuration_proc.call(transport)
            end

            # Call block to apply any customization, if provided
            yield(transport) if block_given?
          end
        end

        # Builds a new Transport::HTTP::Client with default settings
        # Pass a block to override any settings.
        def v7(
          agent_settings: DO_NOT_USE_ENVIRONMENT_AGENT_SETTINGS,
          **options
        )
          new(Transport::Config::Transport) do |transport|
            transport.adapter(agent_settings)
            transport.headers default_headers

            apis = API.defaults

            transport.api API::V7, apis[API::V7]

            # Apply any settings given by options
            unless options.empty?
              transport.default_api = options[:api_version] if options.key?(:api_version)
              transport.headers options[:headers] if options.key?(:headers)
            end

            if agent_settings.deprecated_for_removal_transport_configuration_proc
              agent_settings.deprecated_for_removal_transport_configuration_proc.call(transport)
            end

            # Call block to apply any customization, if provided
            yield(transport) if block_given?
          end
        end

        def default_headers
          {
            Datadog::Transport::Ext::HTTP::HEADER_CLIENT_COMPUTED_TOP_LEVEL => '1',
            Datadog::Transport::Ext::HTTP::HEADER_META_LANG => Datadog::Core::Environment::Ext::LANG,
            Datadog::Transport::Ext::HTTP::HEADER_META_LANG_VERSION => Datadog::Core::Environment::Ext::LANG_VERSION,
            Datadog::Transport::Ext::HTTP::HEADER_META_LANG_INTERPRETER =>
              Datadog::Core::Environment::Ext::LANG_INTERPRETER,
            Datadog::Transport::Ext::HTTP::HEADER_META_TRACER_VERSION => Datadog::Core::Environment::Ext::TRACER_VERSION
          }.tap do |headers|
            # Add container ID, if present.
            container_id = Datadog::Core::Environment::Container.container_id
            headers[Datadog::Transport::Ext::HTTP::HEADER_CONTAINER_ID] = container_id unless container_id.nil?
          end
        end

        def default_adapter
          Datadog::Transport::Ext::HTTP::ADAPTER
        end

        def default_hostname(logger: Datadog.logger)
          logger.warn(
            'Deprecated for removal: Using #default_hostname for configuration is deprecated and will ' \
            'be removed on a future ddtrace release.'
          )

          DO_NOT_USE_ENVIRONMENT_AGENT_SETTINGS.hostname
        end

        def default_port(logger: Datadog.logger)
          logger.warn(
            'Deprecated for removal: Using #default_hostname for configuration is deprecated and will ' \
            'be removed on a future ddtrace release.'
          )

          DO_NOT_USE_ENVIRONMENT_AGENT_SETTINGS.port
        end

        def default_url(logger: Datadog.logger)
          logger.warn(
            'Deprecated for removal: Using #default_url for configuration is deprecated and will ' \
            'be removed on a future ddtrace release.'
          )

          nil
        end

        # Add adapters to registry
        Builder::REGISTRY.set(Datadog::Transport::HTTP::Adapters::Net, Datadog::Transport::Ext::HTTP::ADAPTER)
        Builder::REGISTRY.set(Datadog::Transport::HTTP::Adapters::Test, Datadog::Transport::Ext::Test::ADAPTER)
        Builder::REGISTRY.set(Datadog::Transport::HTTP::Adapters::UnixSocket, Datadog::Transport::Ext::UnixSocket::ADAPTER)
      end
    end
  end
end
