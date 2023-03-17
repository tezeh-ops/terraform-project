# terraform-project

# A repo for the terraform project, and we will be creating and setting rules on how thie repository will be managed.

# Conernig the PR ther will be rule set for approval
# When it comes to credentials, we will set AWS crendentials as our repository secret.
# I will be passing my secrets of AWS in my GITHUB as variable
# EX   
     steps:
...
- name: Unit production
  uses: ...
  env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
