Language.insert_all([
  {
    name: "ruby",
    hex_color: "#701516"
  },
  {
    name: "javascript",
    hex_color: "#F1E05A"
  },
  {
    name: "typescript",
    hex_color: "#3178C6"
  },
  {
    name: "html",
    hex_color: "#E34C26"
  },
  {
    name: "css",
    hex_color: "#563D7C"
  },
  {
    name: "json",
    hex_color: "#292929"
  },
  {
    name: "python",
    hex_color: "#3572A5"
  },
  {
    name: "go",
    hex_color: "#00ADD8"
  },
  {
    name: "java",
    hex_color: "#B07219"
  },
  {
    name: "c",
    hex_color: "#555555"
  },
  {
    name: "c++",
    hex_color: "#F34B7D"
  },
  {
    name: "c#",
    hex_color: "#178600"
  },
  {
    name: "graphql",
    hex_color: "#E10098"
  }
])

account = Account.create(email: "test@example.com", password: "qwe123", status: "verified")

projects = ["Project 1", "Project 2", "Project 3"]
languages = ["ruby", "javascript", "typescript"]
days = (10.days.ago.to_date..Date.today.to_date).to_a

days.each do |day|
  timestamp = day.beginning_of_day
  summary = Summary.find_or_create_by(account_id: account.id, day: day)

  hits = []
  1000.times do
    hits << {
      project: projects.sample,
      language: languages.sample,
      timestamp: timestamp.to_s
    }
    timestamp += rand(1..10).seconds
  end

  Summary.where(id: summary.id).update(raw_hits: hits)
  Summary::Build.perform_now(account:, day:)
end
