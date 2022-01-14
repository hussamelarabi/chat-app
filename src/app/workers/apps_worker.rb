class AppsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(app_name)
    Application.with_advisory_lock('operation-lock') do
      new_app = Application.new(name: app_name, token: generate_token)
      tries = 0

      while tries < 5 && !new_app.save
        new_app = Application.new(name: app_name, token: generate_token)
        tries += 1
      end
    end
  end

  private

  def generate_token
    SecureRandom.base58(24)
  end
end
