#Documentation

## Login Request
Send a POST Request to:
/api/users/login
```php
{
	'Username': 'akifquddus',
	'Password': '**********'
}
```

### Success
Returns 200 Ok Request
```php
{
	'UserId': 1
	'Email': 'abc@gmail.com',
	'FullName': 'Akif Khan',
	'Username': 'akifquddus',
	'Password': null
	'UserType': 1
}
```

### Error 
Returns 400 Bad Request
```php
[
	'Incorrect Username/Password'
]
```

## Sign Up
Send a POST Request to:
/api/users
(Email and Username must be unique)

```php
{
    'Email': 'abc@gmail.com',
	'FullName': 'Akif Khan',
	'Username': 'akifquddus',
	'Password': '**********'
	'UserType': 1
}
```

### Success
Returns 200 Ok Request
```php
{
	'UserId': 1
	'Email': 'abc@gmail.com',
	'FullName': 'Akif Khan',
	'Username': 'akifquddus',
	'Password': null
	'UserType': 1
}
```

### Error
Returns 400 Bad Request
```php
[
	'Details to Error Message'
]
```

# Categories

## Get All Categories
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/categories

### Sample Response
Returns 200 Ok Request
```php
[
    {
        "categoryId": 1,
        "categoryName": "Good Parenting",
        "image": "ImagedatahereinBase4"
    },
    {
        "categoryId": 2,
        "categoryName": "Children",
        "image": "ImagedatahereinBase4"
    }
]
```

## Get Single Category
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/categories/{Category_ID}

### Success
Returns 200 Ok Request
```php
{
    "categoryId": 1,
    "categoryName": "Good Parenting",
    "image": "ImagedatahereinBase4"
}
```

### Error
Returns 400 Bad Request
```php 
[
    "Unable to Find request in database"
]
```

## Add a new Category
Make a POST request to https://webapir20191026025421.azurewebsites.net/api/categories

Sample Data
```php
{
	CategoryName: "Children",
	Image: "{Image data here in Base64}"
}
```

### Success
Returns 200 Ok Request
```php
{
    "categoryId": 1,
    "categoryName": "Children",
    "image": "{ImagedatahereinBase4}"
}
```

### Error
Returns 400 Bad Request (Sample Response in case categoryName is left empty)
```php 
{
    "CategoryName": [
        "The CategoryName field is required."
    ]
}
```

## Update an existing Category
Make a PATCH request to https://webapir20191026025421.azurewebsites.net/api/categories/{category_id}

Sample Data
```php
{
	CategoryName: "Children",
	Image: "{Image data here in Base64}"
}
```

### Success
Returns 200 Ok Request
```php
{
    "categoryId": 1,
    "categoryName": "Children",
    "image": "{ImagedatahereinBase4}"
}
```

### Error
Returns 400 Bad Request
```php 
[
    "Unable to update in database"
]
```

# Articles

## Get All Articles
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/articles

### Sample Response
Returns 200 Ok Request
```php
[
    {
        "articleId": 1,
        "title": "new",
        "content": "new",
        "categoryId": "1,2",
        "image": null
    },
    {
        "articleId": 2,
        "title": "Good Diet for Mothers",
        "content": "Content of the article here, New content can be added",
        "categoryId": "2",
        "image": null
    }
]
```

## Get Single Article
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/articles/{Article_ID}

### Success
Returns 200 Ok Request
```php
{
    "articleId": 1,
    "title": "new",
    "content": "new",
    "categoryId": "1,2",
    "image": null
}
```

### Error
Returns 400 Bad Request
```php 
[
    "Unable to Find request in database"
]
```

## Get Articles by Category_ID
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/articles/getarticles/{Category_ID}

### Success
Returns 200 Ok Request
```php
{
    "articleId": 1,
    "title": "new",
    "content": "new",
    "categoryId": "1,2",
    "image": null
}
```

### Error
Returns 400 Bad Request
```php 
[
    "Unable to Find request in database"
]
```

## Get Articles by Keyword in title
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/articles/searchForArticles/{keywordWithoutPreProcessing}. Keywords are separated by blank spaces in {keywordWithoutPreProcessing}.

### Success
Returns 200 Ok Request
```php
{
        "categoryIds": null,
        "articleId": 1,
        "title": "How to improve your SELF-ESTEEM?",
        "content": "Low self-estee",
        "categoryId": "1,2",
        "image": "{Base64 encoded Image}"
}
```

### Error
Returns 400 Bad Request
```php 
[
    "Unable to Find request in database"
]
```

## Add a new Article
Make a POST request to https://webapir20191026025421.azurewebsites.net/api/articles

Sample Data
```php
{
    "title": "Is sushi good to eat?",
    "content": "Here is the content of the article",
    "categoryId": "1",
    "image": "{Base64 encoded Image}"
}
```
OR in case an article belongs to multiple categories

```php
{
    "title": "Is sushi good to eat?",
    "content": "Here is the content of the article",
    "categoryId": "1,2",
    "image": "{Base64 encoded Image}"
}
```

### Success
Returns 200 Ok Request
```php
{
    "articleId": 3,
    "title": "Is sushi good to eat?",
    "content": "Here is the content of the article",
    "categoryId": "1",
    "image": "{Base64 encoded Image}"
}
```

### Error
Returns 400 Bad Request 
```php 
[
    "Could not add your article"
]
```

## Update an existing Article
Make a PATCH request to https://webapir20191026025421.azurewebsites.net/api/articles/{Article_ID}

Sample Data
```php
{
    "articleId": 2
    "title": "Is sushi good to eat?",
    "content": "Here is the content of the article",
    "categoryId": "1",
    "image": "{Base64 encoded Image}"
}
```

### Success
Returns 200 Ok Request
```php
{
    "articleId": 3,
    "title": "Is sushi good to eat?",
    "content": "Here is the content of the article",
    "categoryId": "1",
    "image": "{Base64 encoded Image}"
}
```

### Error
Returns 400 Bad Request 
```php 
[
    "Could not update your article"
]
```

# Answers

## Post an Answer 
Make a POST request to https://webapir20191026025421.azurewebsites.net/api/answers

Sample Data
```php
{
	questionId: 2,
	userId: 2,
	data: "34"
}
```

### Sample Response
Returns 200 Ok Request
```php
[
    {
		answerId: 1,
		questionId: 2,
		userId: 2,
		data: "34"
	}
]
```

### Error
Returns 400 Bad Request 
```php 
[
    "Unable to perform this operation"
]
```

## Get an Answer by UserID and QuestionID
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/answers/getanswers/{UserID}/{QuestionID}

### Sample Response
Returns 200 Ok Request
```php
[
    {
		answerId: 1,
		questionId: 2,
		userId: 2,
		data: "34"
	}
]
```

### Error
Returns 400 Bad Request 
```php 
[
    "Could not find in the database"
]
```

# Growth

## Post a Growth Update 
Make a POST request to https://webapir20191026025421.azurewebsites.net/api/growth

Sample Data
```php
{
    "userId": 2,
    "weight": 2453,
    "height": 50,
    "head": 34,
    "date": "30/10/2019",
    "childId":1
}
```

### Sample Response
Returns 200 Ok Request
```php
{
    "growthId": 1,
    "userId": 2,
    "weight": 2453,
    "height": 50,
    "head": 34,
    "date": "30/10/2019",
    "childId":1
}
```

### Error
Returns 400 Bad Request 
```php 
[
    "Unable to perform this operation"
]
```

## Get Growth Entries for Specific User 
Make a POST request to https://webapir20191026025421.azurewebsites.net/api/growth/getbyuser/{UserID}

### Sample Response
Returns 200 Ok Request
```php
[
    {
        "growthId": 1,
        "userId": 2,
        "weight": 2453,
        "height": 50,
        "head": 34,
        "date": "30/10/2019",
        "childId":1
    },
    {
        "growthId": 3,
        "userId": 2,
        "weight": 2452,
        "height": 50,
        "head": 34,
        "date": "03/11/2019",
        "childId":2
    }
]
```


# Children

## Get All Children
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/Children

### Sample Response
Returns 200 Ok Request
```php
[
    {
        "childId": 1,
        "userId": 1,
        "borned": false,
        "gender": 0,
        "childName": "lucas",
        "birthDate": "2017-11-01T00:00:00",
        "fatherName": "lucas father",
        "motherName": "Lucas mother"
    },
    {
        "childId": 2,
        "userId": 1,
        "borned": false,
        "gender": 0,
        "childName": "lucas",
        "birthDate": "2017-11-01T00:00:00",
        "fatherName": "lucas father",
        "motherName": "Lucas mother"
    }
]
```

## Get Single Category
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/Children/{Children_ID}

### Success
Returns 200 Ok Request
```php
{
    "childId": 1,
    "userId": 1,
    "borned": false,
    "gender": 0,
    "childName": "lucas",
    "birthDate": "2017-11-01T00:00:00",
    "fatherName": "lucas father",
    "motherName": "Lucas mother"
}
```

### Error
Returns 400 Bad Request
```php 
[
    "Unable to Find request in database"
]
```

## Add a new Child
Make a POST request to https://webapir20191026025421.azurewebsites.net/api/Children

Sample Data
```php
{
    "userId": 1,
    "borned": true,
    "gender": 1,
    "childName": "Lu",
    "birthDate": "2017-11-01T00:00:00",
    "fatherName": "Lu",
    "motherName": "Ma"
}
```

### Success
Returns 200 Ok Request
```php
{
    "childId": 3,
    "userId": 1,
    "borned": true,
    "gender": 1,
    "childName": "Lu",
    "birthDate": "2017-11-01T00:00:00",
    "fatherName": "Lu",
    "motherName": "Ma"
}
```

### Error
Returns 400 Bad Request (Sample Response in case categoryName is left empty)
```php 
[
    "User does not exist"
]
```

## Update an existing Child
Make a PATCH request to https://webapir20191026025421.azurewebsites.net/api/Children/{Children_id}

Sample Data
```php
{
    "userId": 1,
    "borned": true,
    "gender": 1,
    "childName": "Ludd",
    "birthDate": "2017-11-01T00:00:00",
    "fatherName": "Lu",
    "motherName": "Ma"
}
```

### Success
Returns 200 Ok Request
```php
{
    "childId": 1,
    "userId": 1,
    "borned": true,
    "gender": 1,
    "childName": "Ludd",
    "birthDate": "2017-11-01T00:00:00",
    "fatherName": "Lu",
    "motherName": "Ma"
}
```

### Error
Returns 400 Bad Request
```php 
[
    "Unable to update in database"
]
```

## Get existing Children by User
Make a GET request to https://webapir20191026025421.azurewebsites.net/api/Children/getanchildrenbyuser/{User_id}



### Success
Returns 200 Ok Request
```php
[
    {
        "childId": 2,
        "userId": 1,
        "borned": false,
        "gender": 0,
        "childName": "lucas",
        "birthDate": "2017-11-01T00:00:00",
        "fatherName": "lucas father",
        "motherName": "Lucas mother"
    },
    {
        "childId": 3,
        "userId": 1,
        "borned": true,
        "gender": 1,
        "childName": "Lu",
        "birthDate": "2017-11-01T00:00:00",
        "fatherName": "Lu",
        "motherName": "Ma"
    }
]
```

### Error
Returns 400 Bad Request
```php 
[]
```



## Delete an existing Child
Make a DELETE request to https://webapir20191026025421.azurewebsites.net/api/Children/{Children_id}

### Success
Returns 200 Ok Request


### Error
Returns 400 Bad Request
```php 
[
    "Unable to Delete in database"
]
```
