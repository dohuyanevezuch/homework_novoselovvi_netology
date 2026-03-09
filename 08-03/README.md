# Домашнее задание к занятию `GitLab` - `Новоселов Виктор Иванович`

### Задание 1

#### Текст задания


1. Разверните GitLab локально, используя Vagrantfile и инструкцию, описанные в эторепозитории.
2. Создайте новый проект и пустой репозиторий в нём.
3. Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме Docker. Раннер можно регистрировать и запускать на той же виртуальной машине, на которой запущен GitLab.

В качестве ответа в репозиторий шаблона с решением добавьте скриншоты с настройками раннера в проекте.

#### Выполнение задания

Развернули в облачной инфраструктуре gitlab и создали пустой репозиторий

![task1_pic1](./img/01/task1_pic1.png)

Зарегестрировали раннер по иструкции из доп материалов на той же машине

![task1_pic2](./img/01/task1_pic2.png)

![task1_pic3](./img/01/task1_pic3.png)

---

### Задание 2

#### Текст задания

1. Запушьте репозиторий на GitLab, изменив origin. Это изучалось на занятии по Git.
2. Создайте .gitlab-ci.yml, описав в нём все необходимые, на ваш взгляд, этапы.

В качестве ответа в шаблон с решением добавьте:

- файл gitlab-ci.yml для своего проекта или вставьте код в соответствующее поле в шаблоне;
- скриншоты с успешно собранными сборками.


#### Выполнение задания

Запушили репозиторий на gitlab

![task2_pic1](./img/02/task2_pic1.png)

Создали `.gitlab-ci.yml` файл с содержимым

```yaml
stages:
  - test
  - build

test:
  stage: test
  image: golang:1.17
  script: 
    - go test .
  tags:
    - selfhost
build:
  stage: build
  image: docker:latest
  script:
    - docker build .
  tags:
    - selfhost
```

и запушили

Успешная отработка pipline

![task2_pic2](./img/02/task2_pic2.png)

![task2_pic3](./img/02/task2_pic3.png)

---

### Задание 3

#### Текст задания

Измените CI так, чтобы:

- этап сборки запускался сразу, не дожидаясь результатов тестов;
- тесты запускались только при изменении файлов с расширением *.go.

В качестве ответа добавьте в шаблон с решением файл gitlab-ci.yml своего проекта или вставьте код в соответсвующее поле в шаблоне.

#### Выполнение задания

Редактируем файл `.gitlab-ci.yml`

```yaml
stages:
  - test-and-build

test_job:
  stage: test-and-build
  image: golang:1.17
  script: 
    - go test .
  rules:
    - changes: 
        - "*.go"
        - "**/*.go"
      when: on_success
    - when: never
  tags:
    - selfhost

build_job:
  stage: test-and-build
  image: docker:latest
  script:
    - docker build .
  tags:
    - selfhost

```

Спушим изменения и увидим, что отработала только одна джоба

![task3_pic1](./img/03/task3_pic1.png)

Теперь сделам изменения в `main_test.go` файле

```diff
package main

import "testing"

func TestHello(t *testing.T) {
	want := "Hello world!"
	got := hello("world")
	if got != want {
		t.Errorf("want: %s got: %s", want, got)
	}
}

+ // hello
```

Как мы видим, билд все равно ожидает прохождения тестирования, хотя интернет говорит, что запуск джоб в одном стейдже происходит параллельно

![task3_pic2](./img/03/task3_pic2.png)

Пойдем в настройки ранера `/srv/gitlab-runner/config/config.toml` и изменим параметр `concurrent` с 1 на 2 и проверим

Снова редактируем `main_test.go` файл

```diff
package main

import "testing"

func TestHello(t *testing.T) {
	want := "Hello world!"
	got := hello("world")
	if got != want {
		t.Errorf("want: %s got: %s", want, got)
	}
}

- // hello
+ // hello-world
```

И, как мы видим, все отрабатывает отлично

![task3_pic3](./img/03/task3_pic3.png)

![task3_pic4](./img/03/task3_pic4.png)

Последняя проверка, без изменения `go` файлов, просто добавим строчку в `gitlab/GITLAB.md`

![task3_pic5](./img/03/task3_pic5.png)