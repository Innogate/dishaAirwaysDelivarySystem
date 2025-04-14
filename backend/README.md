# tokon : 100
## 101 : Invalid Tokon
# login : 200
# Permition: 300
# Booking: 400

# ADD .htaccess
```conf
RewriteEngine On

# Skip rewriting if it's an existing file or directory
RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^ - [L]

# Rewrite everything to index.php, but preserve the full original URI
RewriteRule ^ index.php [QSA,L]

```

# PAGE IDS
1. Booking
2. States
3. Cities
4. Users
<!-- 5. Companies -->
6. Branch
7. Employees    
8. Permission
9. Booking Slips
10. Co Loader
11. Manifest
12. Delivery
13. PODS

# BOOKING CODES
0 -> IN BRANCH
1 -> OUT FROM BOOKING BRANCH
2 -> OUT FOR DELIVERY
3 -> DIETARY COMPLETE
4 -> CANALED

5 -> forward wait
6 -> outfordelivary wait
7 -> IN REIVING PROCESS