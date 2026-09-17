# Compatibility shim: Rails 4.1's PostgreSQL adapter sets
# `client_min_messages = panic`, a value modern PostgreSQL servers no longer
# accept. Keep the same behaviour without the removed value.
ActiveSupport.on_load(:active_record) do
  require 'active_record/connection_adapters/postgresql_adapter'

  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.class_eval do
    def set_standard_conforming_strings
      execute('SET standard_conforming_strings = on', 'SCHEMA')
    end
  end
end
