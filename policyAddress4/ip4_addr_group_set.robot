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
    Click Menu Sub Panel    object_policy    #id 추가  필요

# 주소 객체 페이지 열기
Open Category IPv4 Address
    Click Menu Cate Level 3    object_policyAddress4     #id 추가  필요
    Check Page Should Be Open    /object/policyAddress4

### 주소 그룹셋 추가 성공 ###
Add IPv4 Group-Set
    Click Button To Open Edit From    btn_grpset_add
    Check Modal Should Be Open    그룹셋 추가
    Select From List By Zone    any
    Input Group Name    robot_test_add_group_set1
    Input Label    asfa@#$%et e#$^%Y

Add IPv4 Group To Group-set
    Click Group Select button    111
    Verify That The Group "111" Exists In The Selected Table
    Click Group Select CheckBox    any_52.114.158.53
    Click Group Select CheckBox    any_10.200.200.51
    Click Button    selected
# Test End
#     Close Browser
