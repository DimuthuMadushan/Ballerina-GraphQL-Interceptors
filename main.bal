import ballerina/graphql;
import ballerina/http;

public enum Scope {
    USER,
    FRIEND,
    OTHER
}

@graphql:ServiceConfig {
    interceptors: [new AccessGrant()],
    contextInit:
    isolated function(http:RequestContext requestContext, http:Request request) returns graphql:Context|error {
        graphql:Context context = new;
        context.set("scope", check request.getHeader("scope"));
        return context;
    },
    graphiql: {
        enable: true
    }
}
isolated service /graphql on new graphql:Listener(9000) {
    isolated resource function get profile() returns Profile {
        return new;
    }
}


public isolated service class Profile {

    isolated resource function get name() returns string {
        return "dimuthu";
    }

    isolated resource function get profilePic() returns string {
        return "link1";
    }

    isolated resource function get bio() returns string {
        return "Student";
    }

    isolated resource function get mobile() returns string? {
        return "+940111348734";
    }

    isolated resource function get birthday/day() returns int? {
        return 5;
    }

    isolated resource function get birthday/month() returns string? {
        return "Octomber";
    }

    isolated resource function get birthday/year() returns int? {
        return 1995;
    }

    isolated resource function get address/street() returns string? {
        return "Main Street";
    }

    isolated resource function get address/homeTown() returns string? {
        return "Deniyaya";
    }

    isolated resource function get address/currentCity() returns string {
        return "Matara";
    }

    isolated resource function get posts/owner() returns Profile {
        return new;
    }

    isolated resource function get posts/likes() returns int {
        return 345;
    }

    isolated resource function get posts/shares() returns int {
        return 4;
    }

    isolated resource function get posts/date/day() returns int? {
        return 3;
    }

    isolated resource function get posts/date/month() returns string? {
        return "August";
    }

    isolated resource function get posts/date/year() returns int? {
        return 2022;
    }
}
