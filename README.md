# Cart Totaller

A Ruby based commandline tool to calculate price of a list of purchases given a reference price guide.
In production, we would probably use a sql db, but for this exercise, I've opted to use the ordered options values as hash keys. Putting aside the string concats to generate the keys, the price lookup is O(1).

### Requirements

ruby 3.x
`bundle install` to install necessary dependencies

### Usage

```bash
  ./run.sh cart.json base-prices.json
  # e.g. with test files
  ./run.sh test-data/cart-9363.json test-data/base-prices.json
```

### Development and testing

Test coverage provided via rspec. You can run the entire suite via

```bash
  ./test.sh
```
