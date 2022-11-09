*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Library    OperatingSystem
Resource    ../SeleniumLibrary-master/atest/acceptance/resource.robot

*** Variables ***
${rowIndex}
${DELAY}    3
${LOGIN_URL}    http://localhost:8080
${BROWSER}    Chrome
${LOGIN_TITLE}    ngfw
${USERNAME_ID}    username
${PASSWORD_ID}    password
${LOGIN_BTN}    login_btn

${WELCOME_URL}    ${LOGIN_URL}/
${MAIN_TITLE}        ngfw
${MAIN_MENU_PANEL_ID}    main-panel
${SUB_MENU_PANEL_ID}    left-panel

${EDIT_FORM_XPATH}    xpath=*//div/form[@id="editFrm"]

${APPLY_BTN_XPATH}    xpath=*//div/button[3][@id="apply"]
${CONFIRM_BTN_ID}    ${EDIT_FORM_XPATH}/div[3]/div/button[3][@id="confirm"]
${ADDMORE_BTN_ID}    XPATH=/html/body/div/div[2]/div[2]/div[2]/div/form/div[3]/div/button[1][@id="btn_add_more"]

${SWAL2_TITLE_XPATH}    xpath=*//div/h2[@id="swal2-title"]
${SWAL2_CONFIRM_BTN}    xpath=/html/body/div[2]/div/div[6]/button[1]
${CANCEL_BTN}    xpath=*//div/button[2][@id="btn_cancel"]

${ZONE_ID}    zone
${TYPE_ID}    type
${NAME_XPATH}    xpath=*//div/input[@name="name"]
${LABEL_XPATH}    xpath=*//div/input[@name="label"]
${ROW_XPATH}    /div[@class='tabulator-tableholder']/div[@class='tabulator-table']/div[@role='row']

${ADDRESS_XPATH}    xpath=*//div/input[@name="address"]
${RANGE_START_XPATH}    xpath=*//div/input[@name="addr_start"]
${RANGE_END_XPATH}    xpath=*//div/input[@name="addr_end"]
${FQDN_XPATH}    xpath=*//div/input[@name="fqdn"]
${ADDR_TABLE_ID}    addr_table

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Set Window Size    1440    1000
    #Set Selenium Speed    ${DELAY}
    Title Should Be    ${LOGIN_TITLE}

User "${username}" logs in with password "${password}"
    Input username    ${username}
    Input password    ${password}
    Submit Credentials

Input Username
    [Arguments]    ${username}
    Input Text    ${USERNAME_ID}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_ID}    ${password}

Submit Credentials
    Click Button    ${LOGIN_BTN}

Welcome Page Should Be Open
    Location Should Be    ${WELCOME_URL}
    Title Should Be    ${MAIN_TITLE}

Wait Loading Container Is Not Visible
    Wait Until Element Is Not Visible    loader-container

Check Page Should Be Open
    Wait Loading Container Is Not Visible
    [Arguments]    ${ip_addr_url}
    Location Should Be    ${LOGIN_URL}${ip_addr_url}

Check Modal Should Be Open
    Wait Loading Container Is Not Visible
    [Arguments]    ${modal_title}
    Page Should Contain    ${modal_title}

##### 메뉴 이동 start #####
Click Menu Main
    Set Browser Implicit Wait    ${DELAY}
    Wait Until Page Contains Element    ${MAIN_MENU_PANEL_ID}
    [Arguments]    ${main_menu}
    Click Element    ${main_menu}

Check Visible Left Panel Menu
    Element Should Be Visible    ${SUB_MENU_PANEL_ID}

Click Menu Sub Panel
    [Arguments]    ${sub_menu}
    Click Element    ${sub_menu}

Click Menu Cate Level 3
    [Arguments]    ${cate_menu}
    Click Element    ${cate_menu}
##### 메뉴 이동 end #####

Click Add Button
    [Arguments]    ${btn_menu}
    Click Button    ${btn_menu}

Select From List By Zone
    [Arguments]    ${zone_name}
    #Select From List By Value    ${ZONE_ID}    ${zone_name}
    ${zoneXpath}=    Set Variable    ${EDIT_FORM_XPATH}/div[2]/div[1]/div/div/div/div/div[1]/div/div[2]/select
    Select From List By Value    ${zoneXpath}    ${zone_name}

Select From List By Address Type
    [Arguments]    ${addr_type}
    ${typeXpath}=    Set Variable    ${EDIT_FORM_XPATH}/div[2]/div/div/div/div/div/div[1]/div[2]/div/div[1]/select
    Select From List By Value    ${typeXpath}    ${addr_type}

Input Group Name
    [Arguments]    ${group_name}
    Input Text    ${NAME_XPATH}    ${group_name}

Input Label
    [Arguments]    ${label}
    Input Text    ${LABEL_XPATH}    ${label}

Input Address
    [Arguments]    ${address}
    Input Text    ${ADDRESS_XPATH}    ${address}

Input FQDN
    [Arguments]    ${fqdn}
    Input Text    ${FQDN_XPATH}    ${fqdn}
    
Input Range Start
    [Arguments]    ${addr_start}
    Input Text    ${RANGE_START_XPATH}    ${addr_start}

Input Range End
    [Arguments]    ${addr_end}
    Input Text    ${RANGE_END_XPATH}    ${addr_end}

Click Add More Button
    Click Button    ${ADDMORE_BTN_ID}

Click Confirm Button
    Click Button    ${CONFIRM_BTN_ID}

Address Column Should Contain
    [Arguments]    ${address}
    Element Should Contain    ${ADDR_TABLE_ID}    ${address}

Get Table Xpath
    [Arguments]    ${tableId}
    ${tableXpath}    Set Variable    *//div[@id="${tableId}"]
    [return]    ${tableXpath}

Get Table Row Count
    [Arguments]    ${rowXpath}
    ${rowCount}=    Get Element Count    ${rowXpath}
    [Return]   ${rowCount} 

Return Flag True Text
    ${var}=    Set Variable    "true"
    [Return]    ${var}

Verify That The Address Group and Group-set "${name}" Exists In The Main Table "${tableId}"
    ${tableXpath}=    Get Table Xpath    ${tableId}
    ${rowXpath}=    Set Variable    ${tableXpath}${ROW_XPATH}
    ${rowCount}=    Get Table Row Count    xpath=${rowXpath}
    FOR    ${rowIdx}    IN RANGE    1    ${rowCount}+1
        ${cellXpath}=    Set Variable    ${rowXpath}\[${rowIdx}\]/div[@class='tabulator-cell'][3]/div[@class='addr_group' or @class='addr_groupset']
        ${cellName}    Get Element Attribute    xpath=${cellXpath}    id
        ${flag}=     Run Keyword If    "${name}" == "${cellName}"    Return Flag True Text
        Exit For Loop If    "${name}" == "${cellName}"
    END
    Should Be True    ${flag}

Verify That The Address "${value}" Exists In The Table "${tableId}"
    ${tableXpath}=    Get Table Xpath    ${tableId}
    ${rowXpath}=    Set Variable    ${tableXpath}${ROW_XPATH}
    ${rowCount}=    Get Table Row Count    xpath=${rowXpath}
    FOR    ${index}    IN RANGE    1    ${rowCount}+1
        ${cellXpath}=    Set Variable    ${rowXpath}\[${index}\]/div[@class='tabulator-cell' and @tabulator-field='address']
        ${cellName}    Get Text    xpath=${cellXpath}
        ${flag}=     Run Keyword If    "${value}" == "${cellName}"    Return Flag True Text
        Exit For Loop If    "${value}" == "${cellName}"
    END
    Should Be True    ${flag}

Get The Row Index Group and Group-set "${name}" In The Main Table "${tableId}"


Add Address Type Address "${address}"
    Select From List By Address Type    address
    Input Address    ${address}
    Click Confirm Button
    # Address Column Should Contain    ${address}
    # Verify That The Address "${address}" Exists In The Table ${ADDR_TABLE_ID}

Add More Address Type Address "${address}"
    Select From List By Address Type    address
    Input Address    ${address}
    Click Add More Button
    # Address Column Should Contain    ${address}

Add More Address Type Address "${address}" Label "${label}"
    Select From List By Address Type    address
    Input Address    ${address}
    Input Label    ${label}
    Click Add More Button
    Address Column Should Contain    ${address}

Add More Address Type Range Start "${addr_start}" End "${addr_end}"
    Select From List By Address Type    range
    Input Address    ${addr_start}
    Input Address    ${addr_end}
    Click Add More Button
    Check Modal Should Be Open    그룹 추가
    Address Column Should Contain    ${addr_start}~"${addr_end}"

Add More Address Type Range Start "${addr_start}" End "${addr_end}" Label "${label}"
    Select From List By Address Type    range
    Input Address    ${addr_start}
    Input Address    ${addr_end}
    Input Label    ${label}
    Click Add More Button
    Check Modal Should Be Open    그룹 추가
    Address Column Should Contain    ${addr_start}~"${addr_end}"

Add More Address Type FQDN "${fqdn}"
    Select From List By Address Type    fqdn
    Click Add More Button
    Check Modal Should Be Open    그룹 추가
    Address Column Should Contain   ${fqdn} 

Add More Address Type FQDN "${fqdn}" Label "${label}"
    Select From List By Address Type    fqdn
    Input Label    ${label}
    Click Add More Button
    Check Modal Should Be Open    그룹 추가
    Address Column Should Contain   ${fqdn} 

Click Button To Open Edit From
    [Arguments]    ${open_btn}
    Click Button    ${open_btn}
    Wait Loading Container Is Not Visible
    # Wait Until Page Contains Element    ${EDIT_FORM_XPATH}    3

 Submit IP Group
    Click Button    ${APPLY_BTN_XPATH}

Check Sucess Apply
    [Arguments]    ${check_name}
    Wait Loading Container Is Not Visible
    # Wait Until Page Contains Element    ${SWAL2_TITLE_XPATH}    3
    Element Should Contain    ${SWAL2_TITLE_XPATH}    성공
    Click Button    ${SWAL2_CONFIRM_BTN}
    Wait Loading Container Is Not Visible
    Verify That The Address Group and Group-set "${check_name}" Exists In The Main Table "table"

Check Fail Apply
    [Arguments]    ${check_name}
    Wait Loading Container Is Not Visible
    # Wait Until Page Contains Element    ${SWAL2_TITLE_XPATH}    3
    Element Should Contain    ${SWAL2_TITLE_XPATH}    오류
    Click Button    ${SWAL2_CONFIRM_BTN}
    Click Button    ${CANCEL_BTN}

Verify That The Group "${value}" Exists In The Selected Table
    ${tableXpath}=    Get Table Xpath    selected_table
    ${rowXpath}=    Set Variable    ${tableXpath}${ROW_XPATH}
    ${rowCount}=    Get Table Row Count    xpath=${rowXpath}
    FOR    ${index}    IN RANGE    1    ${rowCount}+1
        ${cellXpath}=    Set Variable    ${rowXpath}\[${index}\]/div[@class='tabulator-cell' and @tabulator-field='name']/div[@class="addr_group"]
        ${cellName}    Get Text    xpath=${cellXpath}
        ${flag}=     Run Keyword If    "${value}" == "${cellName}"    Return Flag True Text
        Exit For Loop If    "${value}" == "${cellName}"
    END
    Should Be True    ${flag}

Click Group Select button
    [Arguments]    ${group_name}
    ${tableXpath}=    Get Table Xpath    group_table
    ${rowXpath}=    Set Variable    ${tableXpath}${ROW_XPATH}
    ${rowCount}=    Get Table Row Count    xpath=${rowXpath}
    FOR    ${rowIdx}    IN RANGE    1    ${rowCount}+1
        ${cellXpath}=    Set Variable    ${rowXpath}\[${rowIdx}\]/div[@class='tabulator-cell'][3]/div[@class='addr_group']
        ${cellName}    Get Element Attribute    xpath=${cellXpath}    id
        Run Keyword If    "${group_name}" == "${cellName}"    Click Element    xpath=${rowXpath}\[${rowIdx}\]/div[@tabulator-field="add"]
        Exit For Loop If    "${group_name}" == "${cellName}"
    END

Click Group Select CheckBox
    [Arguments]    ${group_name}
    ${tableXpath}=    Get Table Xpath    group_table
    ${rowXpath}=    Set Variable    ${tableXpath}${ROW_XPATH}
    ${rowCount}=    Get Table Row Count    xpath=${rowXpath}
    FOR    ${rowIdx}    IN RANGE    1    ${rowCount}+1
        ${cellXpath}=    Set Variable    ${rowXpath}\[${rowIdx}\]/div[@class='tabulator-cell'][3]/div[@class='addr_group']
        ${cellName}    Get Element Attribute    xpath=${cellXpath}    id
        Run Keyword If    "${group_name}" == "${cellName}"    Click Element    xpath=${rowXpath}\[${rowIdx}\]/div[1]
        Exit For Loop If    "${group_name}" == "${cellName}"
    END