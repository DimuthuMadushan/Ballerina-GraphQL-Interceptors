# Ballerina-GraphQL-Interceptors
A Ballerina GraphQL Example with Interceptors.

This example includes a simple interceptor based GraphQL fields filtering method. This method can be used to filter out the fields based on `Request Header` values.

## Configurations
> NOTE: This example runs only on Ballerina versions greater than `2201.2.0 (Swan Lake Update 2)`.

Example can be run using following command.
```shell
$ bal run
```

#### GrpahiQL
To access the service via GraphiQL, type the following `url` in your browser.
```shell
http://localhost:9000/graphiql
```

When using GraphiQL client, you have to set the `Request Header` in client as follows.
```json
{
  "scope": "FRIEND"
}
```

## GraphQL Schema
```graphql
type Query {
    profile: Profile!
}

type Profile {
    name: String!
    profilePic: String!
    bio: String!
    mobile: String
    birthday: Date
    address: Address
    posts: Post!
}

type Address {
    street: String
    homeTown: String
    currentCity: String!
}

type Date {
    day: Int
    month: String
    year: Int
}

type Post {
    owner: Profile!
    likes: Int!
    shares: Int!
    date: Date
}
```

## Field Accessibility

|  Scope\Field  |  `day`  |       `month`        |       `year`       |        `street`        |      `homeTown`      | `mobile`|
|:-------------:|:-------:|:--------------------:|:------------------:|:-------------------:|:--------------------:|:---------:|
|     `USER`      |    :heavy_check_mark:     | :heavy_check_mark: | :heavy_check_mark: |  :heavy_check_mark: |  :heavy_check_mark:  | :heavy_check_mark: |
|    `FRIEND`     |   :x:   |         :x:          | :heavy_check_mark: |        :x:         |  :heavy_check_mark:  | :heavy_check_mark: |
|     `OTHER`     |   :x:   |         :x:          |        :x:         |        :x:         |         :x:          |       :x:      |

## Sample Responses

***Query***
```grpahql
query {
  profile{
    name
    bio
    mobile
    address{
      street
      currentCity
      homeTown
    }
    birthday{
      day
      month
      year
    }
    posts{
      owner{
        name
      }
      shares
      likes
      date{
        day
        month
        year
      }
    }
  }
}
```

### Response for Scope `USER`
```json
{
  "data": {
    "profile": {
      "name": "dimuthu",
      "bio": "Student",
      "mobile": "+940111348734",
      "address": {
        "street": "Main Street",
        "currentCity": "Matara",
        "homeTown": "Deniyaya"
      },
      "birthday": {
        "day": 5,
        "month": "Octomber",
        "year": 1995
      },
      "posts": {
        "owner": {
          "name": "dimuthu"
        },
        "shares": 4,
        "likes": 345,
        "date": {
          "day": 3,
          "month": "August",
          "year": 2022
        }
      }
    }
  }
}
```

### Response for Scope `FRIEND`
```json
{
  "errors": [
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 7,
          "column": 7
        }
      ],
      "path": ["profile", "address", "street"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 12,
          "column": 7
        }
      ],
      "path": ["profile", "birthday", "day"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 13,
          "column": 7
        }
      ],
      "path": ["profile", "birthday", "month"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 23,
          "column": 9
        }
      ],
      "path": ["profile", "posts", "date", "day"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 24,
          "column": 9
        }
      ],
      "path": ["profile", "posts", "date", "month"]
    }
  ],
  "data": {
    "profile": {
      "name": "dimuthu",
      "bio": "Student",
      "mobile": "+940111348734",
      "address": {
        "street": null,
        "currentCity": "Matara",
        "homeTown": "Deniyaya"
      },
      "birthday": {
        "day": null,
        "month": null,
        "year": 1995
      },
      "posts": {
        "owner": {
          "name": "dimuthu"
        },
        "shares": 4,
        "likes": 345,
        "date": {
          "day": null,
          "month": null,
          "year": 2022
        }
      }
    }
  }
}
```

### Response for Scope `OTHER`
```json
{
  "errors": [
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 5,
          "column": 5
        }
      ],
      "path": ["profile", "mobile"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 7,
          "column": 7
        }
      ],
      "path": ["profile", "address", "street"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 9,
          "column": 7
        }
      ],
      "path": ["profile", "address", "homeTown"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 12,
          "column": 7
        }
      ],
      "path": ["profile", "birthday", "day"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 13,
          "column": 7
        }
      ],
      "path": ["profile", "birthday", "month"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 14,
          "column": 7
        }
      ],
      "path": ["profile", "birthday", "year"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 23,
          "column": 9
        }
      ],
      "path": ["profile", "posts", "date", "day"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 24,
          "column": 9
        }
      ],
      "path": ["profile", "posts", "date", "month"]
    },
    {
      "message": "Access denied!",
      "locations": [
        {
          "line": 25,
          "column": 9
        }
      ],
      "path": ["profile", "posts", "date", "year"]
    }
  ],
  "data": {
    "profile": {
      "name": "dimuthu",
      "bio": "Student",
      "mobile": null,
      "address": {
        "street": null,
        "currentCity": "Matara",
        "homeTown": null
      },
      "birthday": {
        "day": null,
        "month": null,
        "year": null
      },
      "posts": {
        "owner": {
          "name": "dimuthu"
        },
        "shares": 4,
        "likes": 345,
        "date": {
          "day": null,
          "month": null,
          "year": null
        }
      }
    }
  }
}
```