To Do:

1. Add display of error messages

2. Add a custom validation to make sure there aren't repeats of chocolates added

3. Add a validation to make sure a person can only review an chocolate once

4. Displaying flavor and brand in collection select drop down for new review form

5. Scope methods for the following:
    - order chocolats alphabetically
    - order chocolates by brand
    - avg. rating for an chocolate
    - highest rated chocolate
    - lowest rated chocolate
    - top 3 chocolates
    - Top Reviewer (person with the most reviews)

6. Add helper methods for nested route logic

User
- Username
- email
- Password
- has_many reviews
- has_many chocolates through reviews

Brand
- Name
- In_grocery boolien
- has_many chocolates

Chocolate
- belongs_to brand
- belongs_to user
- flavor
- description
- has_many reviews
- has_many users, through reviews

Reviews
- chocolate.id
- user.id
- stars
- title
- content





