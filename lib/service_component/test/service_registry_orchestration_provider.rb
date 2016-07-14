require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class SoarScServiceRegistryOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
      end

      def given_a_valid_service_registry_uri
        @iut.environment['SERVICE_REGISTRY'] = 'http://service-registry.auto-h.net:8080'
      end

      def given_a_service_registry_client_provider
        #TODO does this work?
        credentials = { 'username' => 'uddi', 'password' => 'uddi' }
      end

      def given_no_service_registry_client_provider
        #break the configuration that will result in no service registry client provider
        @iut.configuration['service_registry']['freshness'] = 'not_a_number'
      end

      def given_a_service_registry_client_initialization_failure
        #initialization failure by creating an incorrect configuration
        @iut.configuration['service_registry']['freshness'] = 'not_a_number'
      end

      def given_a_request_for_a_service
        #request is setup as a collection of other aspects right before the request.
      end

      def given_a_policy_for_the_service_exists
        @policy_existance_state = 'existing'
      end

      def given_the_policy_is_registered_with_the_service
        @policy_registration_state = 'registered'
      end

      def given_a_policy_for_the_service_does_not_exists
        @policy_existance_state = 'nonexisting'
      end

      def given_the_policy_is_not_registered_with_the_service
        @policy_registration_state = 'unregistered'
      end

      def given_a_failure
        #simulate a failure by setting the service registry to an invalid uri
        @iut.environment['SERVICE_REGISTRY'] = 'http://invalid-uri.auto-h.net:8080'
      end


      def determine_authorization_for_the_service
        @test_service = "architectural-test-service-with-#{@policy_registration_state}-#{@policy_existance_state}-policy"
        #@iut.environment['IDENTIFIER'] = "service_component.dev.auto-h.net"

        bootstrap #bootstrap will result in the configuration being picked up before any other testing

        @test_id = create_unique_id
        hit_endpoint_requiring_authorization(@test_service,@test_id)
      end

      def i_have_an_initialized_service_registry_client
        false
      end

      def the_client_has_the_full_suite_of_service_registry_functionality
        false
      end

      def has_asked_the_service_registry_for_the_service_policy_name
        #We know that the soar_sc instance reached out or attempted to reach out to the service registry
        #if any of the following error notifications occurred or if the policy itself was requested successfully
        @iut.has_audit_entry_with_message_and_flow_id?('Could not find policy',@test_id) ||
        @iut.has_audit_entry_with_message_and_flow_id?('No policy associated with service',@test_id) ||
        @iut.has_audit_entry_with_message_and_flow_id?('Could not retrieve policy for service',@test_id) ||
        query_last_flow_identifier_from_policy == @test_id
      end

      private

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end

      def query_last_flow_identifier_from_policy
        result = JSON.parse(query_endpoint('authorization-policy-is-anyone/get_latest_flow_identifier', {}))
        result['last_flow_identifier']
      end

      def hit_endpoint_requiring_authorization(test_service,test_id)
        parameters = { :flow_identifier => test_id }
        query_endpoint(test_service,parameters)
      end

      def query_endpoint(resource,parameters)
        require 'uri'
        uri = URI.parse("#{@iut.uri}/#{resource}")
        uri.query = URI.encode_www_form( parameters )
        require 'net/http'
        Net::HTTP.get(uri)
      end

      def create_unique_id
        "#{SecureRandom.hex(32)}"
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Service registry client providing full suite of service registry functionality", ServiceComponent::Test::SoarScServiceRegistryOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Policy lookup",                                                                  ServiceComponent::Test::SoarScServiceRegistryOrchestrationProvider)