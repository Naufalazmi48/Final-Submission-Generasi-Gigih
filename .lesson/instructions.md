# Problem Statement

Mr. Gagah and Ms. Guguh are the parents of Gigih. They have run a catering business for years and write all their orders in their small green book. Gigih is eager to help his parents in running their catering business therefore, he plans to create an automation plan to run this project.

The business process of Gigih parents is like this: Every morning, Mr. Gagah and Ms. Guguh will broadcast some menu items and their price into the catering whatsapp group, usually they can clarify some of the menu items like the price. Then, the customer will message them and order.  Moreover, the customer also can cancel their order if they change their mind before 5pm. In the evening, Mr. Gagah and Ms. Gigih will check the order list for tomorrow morning and prepare the menu accordingly. Apart from that, Mr. Gagah and Ms. Gigih also does revenue calculation based on their total orders.

Gigih is actually a project manager in a big news company called The Eco Mews. He is really good at creating User Stories, however didn’t know backend programming as much as you, a very Gegeh Backend Programmer. Therefore, Gigih hired you to implement the application API for the aforementioned problem.  

# User Stories
|#| Story | Additional Notes |
|---|---|---|
|1  |As an owner,<br />I want to create a new menu item <br />So that I can show them to my customers later|A menu item always has a name, a price, and a category. <br /> <br /> Name of the menu can’t be duplicated. <br /> <br /> Price of the menu can’t be less than 0.01. <br /> <br /> If filled, the description should not exceed 150 characters. <br /> <br /> A menu item can have one category, bonus points if a menu item can have multiple categories.|
|2  |As an owner,<br />I want to update an existing menu item<br /> So that I can modify info related to the menu item |
|3   |  As an owner,<br /> I want to show the list of all menu items<br /> So that my customers can see the list of all menu items that I sell | |
|4   |As an owner,<br /> I want to delete an existing menu item<br /> So that I can remove a menu item that is no longer provided by my catering service|   |
|5  |As an owner, <br /> I want to add customer’s order <br /> So that I can prepare their order| In every order, the owner saves the data of the name and email of the customer who made the order. <br /><br /> Customers can order more than one menu item. For instance, a customer can order both “Nasi Uduk” and “Nasi Kuning”. <br /><br /> For each menu item, customers can order more than one portion. For instance, a customer can order two portions of “Nasi Uduk”. <br /><br /> Please note that as the owner can modify the data of menu items, the change in price of any menu item should not affect its price in any orders that have been created. For instance, if the owner changes the price of “Nasi Uduk” from 15,000 to 20,000, the price of “Nasi Uduk” in all existing orders should not change.|
|6   |As an owner,<br /> I want to update a customer’s order<br /> So that I can modify info related to the order<br />| When an order is first created, the status of that order is ‘new’. If a customer has paid their order, the order status is changed to ‘paid’. The payment process happens outside of this app, the app just has to provide a way for the owner to update the status of an order. <br /> <br /> If a customer does not pay their order five hours after the order is created, the owner will change the status of the order to ‘canceled’. Bonus points if you can provide a way to automatically change the status of any ‘new’ orders that are not changed to ‘paid’ in five hours into ‘canceled’. |
|7   | As an owner,<br /> I want to see a daily report of orders,<br /> So that I can see the revenue that I have generated for that day| Daily report should show the list of orders, the customer of each order, and the total price of each order. <br /><br /> Bonus points if you can provide a way to show reports:<br />1. Based on customer’s email (ex: show report of orders from wkwk@generasigigih.com)<br />2. Based on total price (ex: show report of orders with total price > 50,000)<br />3. Based on a range of dates (ex: show report of orders from April 11-17 2022.)<br /> |

# The Rule of The Game

1. You have 10 days to implement this project, the deadline is at 23 April 11.00 WIB,
2. Use Rails to solve this problem,
3. This problem should be submitted on Replit,
4. When you have any assumption, please write it down inside the README.md, ideally your README.md should help the instructor to grade your API,
5. You are free to use any libraries or gems,
6. Feel free to clarify the requirements to the mentors, and 
7. The problem will be graded only by running RUN from your replit, and going through your UI or routes lists. There should be no extra step required to run the project.

# Grading Criteria
1. You created an UI/API that solved all the 5 sample use case problem,
2. Program should not have an error or crash at any point of time,
3. The program should have the Object Oriented Programming taught from module 1,
4. The program should have the Database, created and manipulated using the DDL and DML taught from module 2,
5. The program should have the MVP architecture in Rails taught from module 3,
6. The program should have Test Driven Development taught from module 4,
7. You have a good and understandable README.md in your solution, this README.md acts as documentation for your solution. As a reference, check this site https://www.makeareadme.com/,
8. Follow the rules of folder structure in rails. Check these website as a reference https://www.tutorialspoint.com/ruby-on-rails/rails-directory-structure.htm,
9. Follow ruby code writing styling guide, follow this website as a style guide https://ruby.style/, 
10. You can integrate the Replit with your Github and having a readable commit history. As a reference, check out this site: https://replit.com/talk/learn/Replit-Git-Tutorial/23331,
11. Ideally your code should be easy to read and easy to navigate, try to use the most correct variable and functions naming as much as possible
