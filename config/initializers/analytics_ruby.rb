Analytics = Segment::Analytics.new({
    write_key: 'N2AR8Z7srhCpK3nS3KAnmkKsbezxEgLc',
    on_error: Proc.new { |status, msg| print msg }
})
