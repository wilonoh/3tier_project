# ec2 instance
resource "aws_instance" "front-server" {
    ami             = var.ami
    instance_type   = var.instance_type
    count           = 2
    key_name        = var.key_name
    associate_public_ip_address = true
    subnet_id = aws_subnet.public_sub1.id
    security_groups = ["${aws_security_group.three_tier_sg.id}"]
    #security_groups = ["${aws_security_group.three_tier_sg.id}"]
    #security_groups = ["aws_security_group.three_tier_sg.id"]
    #vpc_security_group_ids = [aws_security_group.three_tier_sg.id]
    #security_groups = "sg-00c4cfcdb37b5fefc"
    user_data = <<-EOF
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "The page was created by Wilfred" | sudo tee /var/www/html/index.html
    EOF
    # user_data   = <<-EOF

    # #!/bin/bash
    # sudo su
    # yum update -y
    # yum install httpd -y
    # systemctl start httpd
    # systemctl enable httpd
    # echo "<html><hl> Welcome to our channel. Happy learning from $(hostname -f)...</p> </hl
    # EOF

    tags = {
    #Name = "instance${count.index}"
    Name = "front-server.${count.index}"
    }
}