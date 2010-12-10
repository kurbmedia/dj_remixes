module DJ
  class Railtie < Rails::Railtie

    initializer 'dj_remixes_mongoid_backend' do
      if defined?(Delayed::Backend::Mongoid)
        Delayed::Backend::Mongoid::Job.class_eval do
          field :worker_class_name, :type => String
          field :started_at,        :type => DateTime
          field :finished_at,       :type => DateTime  
        end
      end
    end

    initializer :after_initialize do
      require File.join(File.dirname(__FILE__), 'requires')
      
      ActiveSupport.on_load(:action_mailer) do
        require File.join(File.dirname(__FILE__), 'action_mailer/action_mailer')
      end
      
    end

  end
end