# variable "stage_name" {
#     description = "name of the stage choose"
  
#     type = string
# }


# resource "aws_api_gateway_stage" "stage" {
    
#     //stage parameter
#     stage_name = var.stage_name
#     rest_api_id = //module.api_gateway.apigatewayv2_api_id
#     deployment_id = //module.api_gateway.apigatewayv2_api_id
# }

resource "aws_api_gateway_rest_api" "example" {
  name = "test-stage"
  //protocol_type = "HTTP"
}

resource "aws_api_gateway_resource" "example" {
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "test-stage"
  rest_api_id = aws_api_gateway_rest_api.example.id
}

resource "aws_api_gateway_method" "example" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.example.id
  //api_id   = aws_api_gateway_rest_api.example.id
}

resource "aws_api_gateway_integration" "example" {
  http_method = aws_api_gateway_method.example.http_method
  resource_id = aws_api_gateway_resource.example.id
  //api_id = aws_api_gateway_rest_api.example.id
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "example" {
  //api_id = aws_api_gateway_rest_api.example.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.example.id,
      aws_api_gateway_method.example.id,
      aws_api_gateway_integration.example.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = "test-stage"
}
