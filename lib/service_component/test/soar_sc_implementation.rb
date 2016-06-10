require 'json'
require 'yaml'
require 'jsender'

module ServiceComponent
  module Test
    class SoarScImplementation
      include Jsender

      attr_reader :uri
      attr_reader :identifier
      attr_reader :environment
      attr_reader :configuration

      def initialize(uri)
        @uri = uri
        @messages_file = "#{ENV['SOAR_DIR']}/webrick.stdout"
        @environment_file = "#{ENV['SOAR_DIR']}/config/environment.yml"
        @configuration_file = "#{ENV['SOAR_DIR']}/config/config.yml"
        @environment = load_file(@environment_file)
        @configuration = load_yaml_file(@configuration_file)
      end

      def identify(identifier)
        @identifier = identifier
      end

      def clear_messages
        File.delete(@messages_file)
      end

      def has_sent_notification?(message)
        found = `grep '#{message}' #{@messages_file}`
        found.size > 0
      end

      def get_latest_audit_entries(lines = 1)
        `tail -n #{lines} #{@messages_file}`
      end

      def bootstrap(environment)
        environment['IDENTIFIER'] = @identifier
        soar_dir = ENV['SOAR_DIR']
        puts "NOTE: Run keep_running.sh in #{soar_dir} using SOAR_TECH=rackup"
        if (soar_dir.nil?) or (soar_dir.strip == '')
          puts "SOAR_DIR not defined"
          return
        end
        bootstrap_with_environment(environment, @environment_file)
        `cd #{soar_dir}&&./stop.sh`
        detail = get_status_detail
        return fail if detail.nil?
        success_data(detail)
      end

      def get_status_detail
        success = false
        attempts = 1
        threshold = 5
        response = nil
        while (not success) and (attempts <= threshold) do
          begin
            printf "!"
            status_detail_uri = 'http://localhost:9393/status-detail'
            response = Net::HTTP.get(URI.parse(status_detail_uri))
            success = true
          rescue
            success = false
            sleep 1
            attempts = attempts + 1
          end
        end
        return nil if not success
        JSON.parse(response)
      end

      def bootstrap_with_environment(environment, environment_file)
        File.delete(environment_file)
        File.open(environment_file, 'w') { |f| f.write environment.to_yaml }
      end

      def load_yaml_file(file_name)
        YAML.load_file(file_name)
      end

      def load_file(file_name)
        if File.exist?(file_name)
          stringify_values(YAML.load_file(file_name))
        else
          {}
        end
      rescue IOError, SystemCallError, Psych::Exception => ex
        raise LoadError.new("Failed to load environment #{file_name} : #{ex}")
      end

      def stringify_values(hash)
        Hash[hash.map{ |k, v| [k, v.to_s] }]
      end
    end
  end
end
