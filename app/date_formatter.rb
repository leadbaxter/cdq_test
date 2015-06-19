  module DateFormatter

    def self.dateFormatter
      @dateFormatter ||= NSDateFormatter.alloc.init.tap do |df|
        df.setDateStyle(NSDateFormatterMediumStyle)
        df.setTimeStyle(NSDateFormatterNoStyle)
      end
    end

    def self.stringFromDate(date, format = nil)
      df = dateFormatter
      df.setDateFormat(format || 'yyyy-MM-dd HH:mm:ss ZZ')
      df.stringFromDate(date)
    end

    def self.dateFromString(string, format = nil)
      df = dateFormatter
      df.setDateFormat(format || 'yyyy-MM-dd HH:mm:ss ZZ')
      df.dateFromString(string)
    end

  end
