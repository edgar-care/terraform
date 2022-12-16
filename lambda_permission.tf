resource "aws_lambda_permission" "route" {
    for_each = {for vm in var.lambda_permissions: vm.state_id => vm}

    statement_id = "${each.value.state_id}"
    action = "lambda:InvokeFunction"
    function_name = "${each.value.name}"
    principal = "apigateway.amazonaws.com"
    
    source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${module.api_gateway.apigatewayv2_api_id}/*/${each.value.route}"
}