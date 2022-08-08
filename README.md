# Ballerina-GraphQL-Interceptors
A Ballerina GraphQL Example with Interceptors.

This example includes a simple interceptor based GraphQL fields filtering method. This method can be used to filter out the fields based on `Request Header` values.

## Configurations
> NOTE: This example runs only on Ballerina versions greater than `SL2022.2.0`.

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
```

## Field Accessibility

|  Scope\Field  |  `day`  |       `month`        |      `street`       |      `homeTown`      | `mobile`|
|:-------------:|:-------:|:--------------------:|:-------------------:|:--------------------:|:---------:|
|     `USER`      |    :heavy_check_mark:     |  :heavy_check_mark:  |  :heavy_check_mark: |  :heavy_check_mark:  | :heavy_check_mark: |
|    `FRIEND`     |   :x:   |         :x:          |         :x:         |  :heavy_check_mark:  | :heavy_check_mark: |
|     `OTHER`     |   :x:   |         :x:          |         :x:         |         :x:          |       :x:      |
