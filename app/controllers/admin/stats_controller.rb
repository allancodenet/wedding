module Admin
  class StatsController < Admin::ApplicationController
    def index
      @stats = {
        user_count: User.count,
        client_count: Client.count,
        provider_count: Provider.count,
        draft_count: Provider.draft.count,
        published_count: Provider.published.count
      }
    end
  end
end
