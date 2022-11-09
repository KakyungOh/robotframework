*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Resource    resources.robot

*** Test Cases ***
# 로그인
Valid Login
    Given Open Browser To Login Page
    When User "axroot" logs in with password "Admin12#$"
    Then Welcome Page Should Be Open
    # [Teardown]    Close Browser

# 왼쪽 메뉴 패널 열기
Open Sub Menu Panel Object
    Click Menu Main    object
    Check Visible Left Panel Menu
    Click Menu Sub Panel    object_policy

# 주소 객체 페이지 열기
Open Category IPv4 Address
    Click Menu Cate Level 3    object_policyAddress4
    Check Page Should Be Open    /object/policyAddress4

### 주소 그룹 추가 성공 ###
Add IPv4 Group
    Click Button To Open Edit From    btn_grp_add
    Check Modal Should Be Open    그룹 추가
    Select From List By Zone    trust
    Input Group Name    robot_test_add_group1
    Input Label    asfa@#$%et e#$^%Y
Add IPv4 Group Address
    Click Button To Open Edit From    btn_add
    Check Modal Should Be Open    주소 추가
    Add More Address Type Address "2.3.4.5"
    Verify That The Address "2.3.4.5" Exists In The Table "addr_table"
    Add More Address Type Address "6.6.6.6"
    Verify That The Address "6.6.6.6" Exists In The Table "addr_table"
    Add Address Type Address "4.5.6.7"
    Verify That The Address "4.5.6.7" Exists In The Table "addr_table"
# Check Address List
   
Apply Sucess IPv4 Group
    Submit IP Group
    Check Sucess Apply    robot_test_add_group1

Test End
    Close Browser
