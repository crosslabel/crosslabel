Analytics = Segment::Analytics.new({
    write_key: Rails.application.secrets.segment_write_key,
    on_error: Proc.new { |status, msg| print msg }
})
