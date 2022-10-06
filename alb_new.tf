# # security group
# resource "aws_security_group" "front-server" {
#     name        = "front-server"
#     description = "allow incoming http connections"

#     ingress {
#         from_port   = 80
#         to_port     = 80
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     egress  {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
# }

# target group
resource "aws_lb_target_group" "target-group" {
    health_check {
        interval            = 10
        path                = "/"
        protocol            = "HTTP"
        #protocol            = "TCP"
        port                = 80
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
    }

    name            = "alb-tg"
    port            = 80
    protocol        = "HTTP"
    target_type     = var.target_type
    vpc_id = aws_vpc.three_tier_vpc.id
}

# alb
resource "aws_lb" "app-lb" {
    name            = "application-lb" 
    internal        = false
    ip_address_type = var.ip_address_type
    load_balancer_type  = var.load_balancer_type
    #security_groups     = [aws_security_group.front-server.id]
    security_groups     = [aws_security_group.three_tier_sg.id]
    subnets = [aws_subnet.public_sub1.id,aws_subnet.public_sub2.id]

    tags = {
        name = "application-lb"
    }
}

# listener
resource "aws_lb_listener" "app-listener" {
    load_balancer_arn       = aws_lb.app-lb.arn
    port                    = 8080
    protocol                = "HTTP"
    default_action {
        target_group_arn    = aws_lb_target_group.target-group.arn
        type                = "forward"
    }
}

# attachment
resource "aws_lb_target_group_attachment" "instance_attach" {
    count = length(aws_instance.front-server)
    target_group_arn = aws_lb_target_group.target-group.arn
    target_id        = aws_instance.front-server[count.index].id
}