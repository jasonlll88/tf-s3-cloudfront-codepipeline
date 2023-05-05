resource "aws_lambda_function" "lambda_function" {
  function_name = local.lambda_function_name
  runtime = "python3.9"
  handler = "invalidate.lambda_handler"
  timeout = 60
  memory_size = 128

  filename = "${path.module}/lambda-function/invalidate.zip"

  role = aws_iam_role.lambda_role.arn

  tags = merge(local.tags,{Name = local.lambda_function_name})    

}


resource "aws_iam_role" "lambda_role" {
  name = "${var.name_prefix}-${var.lambda_name}${var.name_suffix}-role"
  assume_role_policy = data.template_file.lambda_trust_relationship.rendered
  tags = merge(local.tags,{Name = "${var.name_prefix}-${var.lambda_name}${var.name_suffix}-role"}) 
}

resource "aws_iam_role_policy" "lambda_iam_role_policy" {
  name   = "${var.name_prefix}-${var.lambda_name}${var.name_suffix}-policy"
  role   = aws_iam_role.lambda_role.name
  policy = data.template_file.lambda_policy.rendered
}

data "template_file" "lambda_policy" {
  template = file("${path.module}/policies/lambda_policy.json")
}

data "template_file" "lambda_trust_relationship" {
  template = file("${path.module}/policies/lambda_trust_relationship.json")
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda-function/invalidate.py"
  output_path = "${path.module}/lambda-function/invalidate.zip"
}