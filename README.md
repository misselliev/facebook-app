# Facebook App

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]

Building a functional clone of Facebook.

Built with Rails 5.2. Powered by teal coffee.


## Usage

You can use our live version [here](https://fkbook.herokuapp.com/) or install and run in your local machine.

To install please clone the repository

```sh
$ git clone https://github.com/misselliev/facebook-app.git
```

cd into Facebook-app folder

```
$ cd facebook-app
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ rails server
```

And open your browser in localhost

```
$ http://localhost:3000/
```

## Release History

Currently working on: You can leave messages on a friend's wall

## Developers

- [Santiago Torres](https://github.com/stiakov)
- [Elizabeth Villalejos](https://github.com/misselliev/)

## Contributing

1. Fork it (https://github.com/misselliev/facebook-app/fork)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

<!-- Markdown link & img dfn's -->

[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[wiki]: https://github.com/yourname/yourproject/wiki

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE - see the [LICENSE](https://github.com/misselliev/facebook-app/blob/master/LICENSE) file for details

"Looking at code you wrote more than two weeks ago is like looking at code you are seeing for the first time." Dan Hurvitz
