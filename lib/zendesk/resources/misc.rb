module Zendesk
  class Activity < Resource
    has :user
    has :actor, :class => :user
  end

  class Setting < DataResource
    attr_reader :on

    def initialize(client, attributes = {})
      @on = attributes.first
      super(client, attributes[1])
    end
  end

  class MobileDevice < Resource
    put :clear_badge
  end

  class SatisfactionRating < ReadResource
    has :assignee, :class => :user 
    has :requester, :class => :user
    has :ticket
    has :group
  end
  
  class Attachment < Data
    def self.create(client, attributes)
      upload = Upload.create(client, attributes)

      if upload
        self.new(client, { :token => upload.token })
      end
    end

    def to_param
      @attributes[:token]
    end
  end

  class Upload < Data
    extend Create
    has_many :attachments
  end

  class Locale < ReadResource; end
  class Bookmark < Resource; end
  class Macro < DataResource; end
end
