// Done in group

import ballerina/http;

# API for effectively managing staff, their offices, and allocated  courses within the Faculty of Computing and Informatics.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config =  {}, string serviceUrl = "http://localhost:8080/") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings { 
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Creates a new lecturer
    #
    # + return - successfull registration 
    resource isolated function post newlecturer(Lecturer payload) returns Inline_response_201|error {
        string resourcePath = string `/newlecturer`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Inline_response_201 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Fetches all lecturers
    #
    # + return - List of students 
    resource isolated function get lecturers() returns Lecturer[]|error {
        string resourcePath = string `/lecturers`;
        Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Updates an existing lecturer details
    #
    # + return - Operation was successful 
    resource isolated function put updatelecturerdetails(Lecturer payload) returns Inline_response_200|error {
        string resourcePath = string `/updatelecturerdetails`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Inline_response_200 response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Server returns the lecturer with which the staff_number passed in identifies.
    #
    # + staff_number - unique identifier for a lecturer
    # + return - Operation successfull 
    resource isolated function get lecturerbystaffnumber/[string staff_number]() returns Lecturer|error {
        string resourcePath = string `/lecturerbystaffnumber/${getEncodedUri(staff_number)}`;
        Lecturer response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Deletes an existing lecturer
    #
    # + staff_number - unique identifier for a lecturer
    # + return - Operation was successful 
    resource isolated function delete deletelecturer/[string staff_number]() returns Inline_response_200|error {
        string resourcePath = string `/deletelecturer/${getEncodedUri(staff_number)}`;
        Inline_response_200 response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Server returns a list of all the lecturers that teach  the course identified by the passed in course code
    #
    # + course_code - unique identifier for a single course
    # + return - Successfully returned list of lecturers 
    resource isolated function get lecturersbycoursecode/[string course_code]() returns Lecturer[]|error {
        string resourcePath = string `/lecturersbycoursecode/${getEncodedUri(course_code)}`;
        Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Server returns a list of all the lecturers that are located at the office identified by the passed in office number
    #
    # + office_number - unique identifier for a single office
    # + return - Successfully returned list of lecturers 
    resource isolated function get lecturersbyofficenumber/[string office_number]() returns Lecturer[]|error {
        string resourcePath = string `/lecturersbyofficenumber/${getEncodedUri(office_number)}`;
        Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
}
