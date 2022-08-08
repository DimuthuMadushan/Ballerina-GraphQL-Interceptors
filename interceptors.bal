import ballerina/graphql;

readonly service class AccessGrant {
    *graphql:Interceptor;

    isolated remote function execute(graphql:Context context, graphql:Field 'field) returns anydata|error {
        var scope = check context.get("scope");
        if scope is string && !self.grantAccess(scope, 'field.getName()) {
            return error("Access denied!");
        }
        return context.resolve('field);
    }

    isolated function grantAccess(string scope, string fieldName) returns boolean {
        string[] restrictedForFriends = ["day", "month", "homeTown", "street"];
        string[] restrictedForOther = ["day", "month", "year", "homeTown", "street", "mobile"];
        if scope is FRIEND && restrictedForFriends.indexOf(fieldName) is int {
            return false;
        }else if scope is OTHER && restrictedForOther.indexOf(fieldName) is int {
            return false;
        }
        return true;
    }
}
