![Issues](https://img.shields.io/github/issues/marcusal/food-delivery-app?style=for-the-badge)
![Followers](https://img.shields.io/github/followers/marcusal?style=for-the-badge)
![Stars](https://img.shields.io/github/stars/marcusal?style=for-the-badge)
![Pull Requests](https://img.shields.io/github/issues-pr/food-delivery-app?style=for-the-badge)
![Last Commit](https://img.shields.io/github/last-commit/marcusal/food-delivery-app/main?style=for-the-badge)

# Food Delivery App
In this project, I have created a simple Terminal App. The data is stored via csv, and CRUD actions are implemented using Ruby code.

<img align="right" alt="GIF" height="160px" src="https://media.giphy.com/media/dAzkOoCgoFHtCAdFhe/giphy.gif"/>

## Built With Ruby

![Ruby](http://img.shields.io/badge/-Ruby-3776AB?style=flat-square&logo=ruby&logoColor=red)

## Prerequisites

Ruby 2.6 (Or later)

## How to Test for Errors

1. Install Ruby
2. Access the app folder in the terminal
3. Run app.rb
```
$ ruby app.rb
```


__Clone the repo to your local machine using the terminal__:
```
$ git clone https://github.com/Marcusal/mvc-hackernews-blog
```

## How to Use

1. Run by typing in your terminal: 
```
$ ruby bin/app.rb
```
Our repository is initialized with a CSV file path. It has a **read-only** logic since only the administrator of our app can create accounts. The interface of this repository allows to:
- Get all the riders from the repository
- Find a specific employee thanks to its id
- Find a specific employee thanks to username

### `Employee` model

Our restaurant has two types of employees, **managers** and **riders**. Both have an id, a username and a password, but they have different privileges depending of their roles.

We want to have two menus in the router: one listing the tasks for managers and one listing the tasks for riders.

To handle that, we'll introduce the notion of a **session**. At the router level, we'll store the logged-in user in a session.

The sign-in sequence:

```bash
> username?
paul
> password?
blablabla
Wrong credentials... Try again!
> username?
paul
> password?
secret
Welcome Paul!
```
- As a manager, I can add a new order
- As a manager, I can list all the undelivered orders
- As a rider, I can mark one of my orders as delivered
- As a rider, I list all my undelivered orders

- Additional user actions:
- As a manager, I can edit an existing order
- As a manager, I can destroy an existing order

The controller delegates the work to the other components of our app (model, repository and views)

## Authors

👤 **Marcus**

- GitHub: [@Marcusal](https://github.com/Marcusal)
- LinkedIn: [Mark Allen](https://www.linkedin.com/in/marcusa999/)


## Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Marcusal/mvc-hackernews-blog/issues)

## 📝 License

This project is [MIT](LICENSE) licensed.

