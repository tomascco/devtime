<div align="center">
  <br>
  <img src="devtime.png" alt="Devtime Logo" width="50%"/>
  <br>
  <h3>
    <strong>active coding time data for developers</strong>
  </h3>
</div>
<br>

# DevTime

DevTime is a tool for track how much time developers spend while coding on their favorite text editor.

- ⏲️ It tracks how much time you spend in each day of the week
- ↔️ It compares how much time you spend today against your week average
- ☀️🌄🌜 It tracks your activity throughout the day, so you can discover the hour that you produce more code
- And many more features are coming 🚀...

## Instalation

### Beta Application
You can use the application hosted in Heroku. It's in beta, so you can lose all data tracked in the official release.

[devtimer.herokuapp.com](https://devtimer.herokuapp.com/)

### Local Server

You can run your own server by cloning the repository. It is also good because all data being stored belongs to you!

Clone the project

```
git clone https://github.com/mtayllan/devtime.git
```

We use Ruby on Rails and PostgreSQL, thus you need to have a environment that can run Ruby on Rails + PostgreSQL applications.

> Docker Setup: comming soon

Setup Environment Variables by copying the .env.example file and replacing with environment files.
```
...
HOST='localhost'
PORT='3000'
```

```
bundle install
rails db:setup
```
Then to run the server use:
```
rails server
```

### Extension

We currently only support VSCode
You can download the extension [here](https://marketplace.visualstudio.com/items?itemName=mtayllan.devtimee-vscode)

The extension is also Open Souce, you can check the code [here](https://github.com/mtayllan/devtime-vscode).

With the extension installed, you can configure it with the host and the token present in profile page.

## Contributing
Feel free to open a issue and create a pull request. We currenty don't have strict rules for it.

## Community

You can talk with us at Discord.

[JOIN HERE](https://discord.gg/ehQCkvdKEX)


## License
MIT © mtayllan
