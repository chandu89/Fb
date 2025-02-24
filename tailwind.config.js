module.exports = {
  purge: {
    content: ['./app/views/**/*.html.erb', './app/javascript/**/*.js'],
    safelist: ['hidden', 'block'],
  },
}
