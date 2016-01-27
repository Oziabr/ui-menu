# ui-router state driven menu directive

[![Build Status](https://travis-ci.org/Oziabr/ui-menu.svg?branch=master)](https://travis-ci.org/Oziabr/ui-menu)

Also made to be a starting point for BDD module development.

With CoffeeScript and coverage reports.

And some other stuff which made code more humane.

## Demo

http://htmlpreview.github.io/?https://github.com/Oziabr/ui-menu/blob/master/example.html

## Features

#### As Menu Directive (end-users)

- Setup from ui-router states
- One project-wise recursive navigation menu
- Flat inner-page menus
- Ordering
- Icons (FontAwesome)
- Default tab pre-select
- Collapsible navigation
- Fix ui-sref-active on navigation
- [TODO] Flexible templates
- [TODO] Handling abstract states

#### As Module Boilerplate (dev)

- Coffee!!! (full support)
- Integrated BDD
- Coverage reports
- Stubs for service and directive tests
- Live demo
- [TODO] Live usage info
- Basic build system
- [TODO] Build system (annotation, minification)
- [TODO] Autoreload

## Dependencies

- lodash (just because)
- angular
- angular-ui-router
- angular-animate (collapsible navigation)
- ui-bootstrap    (collapsible navigation)


## Install

```wget https://raw.githubusercontent.com/Oziabr/ui-menu/master/ui-menu.js```

## Build

```npm run-script build```

## Usage

Check example https://github.com/Oziabr/ui-menu/blob/master/example.coffee
