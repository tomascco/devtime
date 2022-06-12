// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
import ClipboardController from "./clipboard_controller"
import HomeChartsController from "./home_charts_controller"

application.register("hello", HelloController)
application.register("clipboard", ClipboardController)
application.register("home-charts", HomeChartsController)
