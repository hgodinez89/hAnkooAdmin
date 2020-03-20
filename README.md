<p align="center">
  <img src="https://res.cloudinary.com/developerteam/image/upload/v1584624286/hAnkooAdministration/hAnkoo.png" alt="Logo"width=180 height=180>

  <h3 align="center">hAnkoo Administration</h3>

  <p align="center">
    This is an administration software.
    <br>
    <a href="https://github.com/hgodinez89/hAnkooAdmin/issues/new">Report bug</a>
  </p>
</p>


## What’s In This Document
- [What’s In This Document](#whats-in-this-document)
- [What is this?](#what-is-this)
- [Version History](#version-history)
- [Have questions?](#have-questions)

## What is this?

This is an administration software for a micro-company to manage its stock, customers, delivery routes, sales, accounts receivable, security, notifications, and more. It was developed with PL/SQL, Oracle Forms & Reports 6i, SQL, Java, and Oracle Database.
This application has 9 modules for every business segment, this is a brief description of each of them:
* CL: The Customer module allows you to create, update and query customers.
* CO: The Accounts Receivable module allows you to manage the balance due of every customer.
* IV: Stock module allows you to manage your own products, costs, prices, quantity, location, and more.
* NF: Notifications module allows you to define your own alerts, for example payments overdue, products with low stock, and more. This notifications can be to set up to a specify group of users, and they can check them in their own inbox.
* PA: System Parameters is the module that allows to set up general parameters like information about the company, currencies, and more.
* PG: Payments module allows you to apply the payments received from the customers.
* RU: Routes module allows you to manage the delivery routes and the workers of them.
* SE: Security module allows you to create and update users and security roles, as well as the admin user can do a full backup of the application data.
* VT: Sales module allows you to do sales to registered and unregistered customers. For the registered customers users can do sales with two options cash sale or credit sale.
This project contains the following folders structure:</br> </br>
```
hAnkooAdmin
│   NN60.DLL: This file should replace the file NN60.DLL path ORACLE_HOME\bin, this action allows you to work seamlessly with reports.
│   NNB60.DLL: This file should replace the file NNB60.DLL path ORACLE_HOME\bin, this action allows you to work seamlessly with reports.
└───forms: Folder that contains the files with the extension .fmb
└───icons: This folder contains the files with the extension .ico
└───images: It contains the files with the extensions .jpg, .png, .gif, .bmp, so on.
└───jar: This folder contains the files with the extension .jar, in this case files that allows users to authenticate with their fingerprint.
└───libraries: Folder that contains the files with the extension .pll, these files are usage by most .fmb files.
└───reports: It contains the files with the extensions .rdf
└───scripts: This folder contains the files with the extension .sql, in this case, the files allows you to create all the oracle database objects, like tables, procedures, functions, package, triggers, and more.
```
</br>
Thanks for your visiting! 👍

## Version History

| Version |       Date         |             Comments             |
| ------- | ------------------ | -------------------------------- |
| 1.0     | January 2013       | Initial release                  |

## Have questions?

If you have questions or just need any help, feel free to write to me 
<a href="mailto:hgodinez89@hotmail.com">hgodinez89@hotmail.com</a>
