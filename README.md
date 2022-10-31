# Robot Framework SeleniumLibrary 설치



## Python 설치

python 3.10 기준

## pip 최신 버전 업그레이드

```
python -m pip install --upgrade pip
```

## Selenium library 설치

```
pip install --upgrade robotframework-seleniumlibrary
pip install --upgrade robotframework-selenium2library
pip install robotframework-selenium2library==1.8.0
pip install git+https://github.com/robotframework/SeleniumLibrary.git
```

## Webdrivermanager 사용

프로젝트 디렉토리 안에 사용할 브라우저의 드라이버 설치 필요

1. 수동 설치

    사용중인 브라우저의 버전을 확인 한 후 해당 사이트에서 수동으로 다운로드

2. 자동 설치

    Webdrivermanager로 자동 설치 가능

    ```
    pip install webdrivermanager
    webdrivermanager chrome --linkpath /myDir
    ```

    설치 중 아래와 같은 오류 발생 시 pyOpenSSL 업데이트 필요

    "Failed to parse compatible version: HTTPSConnectionPool(host='www.googleapis.com', port=443): Max retries exceeded with url: /storage/v1/b/chromedriver/o/LATEST_RELEASE_106.0.5249 (Caused by SSLError(SSLCertVerificationError(1, '\[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: self signed certificate in certificate chain (_ssl.c:997)')))
Unable to download webdriver's at this time due to network connectivity error"

    ```
    pip install pyOpenSSL
    pip install webdrivermanager
    webdrivermanager chrome --linkpath /myDir
    ```

## VS Code 확장팩 설치

Python Extension Pack

Robot Framework Language Server


## 참고 : RIDE(Robot framework IDE)

Robot framework IDE를 제공하고 있음.

```
pip install wxPython
pip install psutil
pip install -U --pre robotframework-ride
```

## 참고 사이트

- [ ] [Robot Framework](https://robotframework.org/)
- [ ] [Selenium Library](https://github.com/robotframework/SeleniumLibrary/)
- [ ] [Selenium Library KeyWords](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
- [ ] [Selenium Library KeyWords 사용 예제](https://intrepidgeeks.com/tutorial/creating-keywords-in-robot-framework-using-python)
