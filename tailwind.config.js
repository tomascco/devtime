module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("@tailwindcss/typography"), require('daisyui')],
  daisyui: {
    themes: [
      {
        garden: {
          "color-scheme": "light",
          "primary": "#5c7f67",
          "secondary": "#ecf4e7",
          "secondary-content": "#24331a",
          "accent": "#fae5e5",
          "accent-content": "#322020",
          "neutral": "#5d5656",
          "neutral-content": "#e9e7e7",
          "base-100": "#e9e7e7",
          "base-content": "#100f0f",
          "error": "#e11d48"
        }
      }
    ]
  }
}
