class Hit
  VERSION = 1

  attr_reader :timestamp
  attr_reader :project
  attr_reader :language

  def initialize(params)
    @language = params[:language]
    @project = params[:project]
    begin
      @timestamp = Time.parse(params[:timestamp])
    rescue
      @timestamp = nil
    end
  end

  def valid?
    @language.present? && @project.present? && @timestamp.present?
  end

  def to_json
    {
      version: VERSION,
      timestamp: @timestamp,
      language: @language,
      project: @project
    }.to_json
  end
end
