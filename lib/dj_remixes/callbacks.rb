module DJ
  class Worker
    
    def before(job)
      self.dj_object = job
      (job.respond_to?(:touch) ? job.touch(:started_at) : job.update_attributes(:started_at => Time.now))
    end
    
    def after(job)
    end
    
    def success(job)
      (job.respond_to?(:touch) ? job.touch(:finished_at) : job.update_attributes(:finished_at => Time.now))
      self.enqueue_again if self.respond_to?(:enqueue_again)
    end
    
    def error(job, error)
      job.update_attributes(:started_at => nil)
    end
    
  end # Worker
end # DJ