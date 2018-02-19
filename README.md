# teamcity-docker-compose

Compose to create working [TeamCity](TeamCity) server with PostgreSQL and Agents

## How to use

Clone this repository or download the zip.

```bash
git clone https://github.com/QuintSys/teamcity-docker-compose.git
```

## Configuration

Set your Postgres username and password variables in `env.example` and rename `env.example` to `.env`

Don't push `.env` file in public repositories!

PostgreSQL is already configured according to the
JetBrains [recommendations](recommendations)

## Build and setup

Next, build the images:

```bash
cd teamcity-docker-compose
docker-compose build
```

Now you can start up the service and continue configuring settings in Web Interface:

```bash
docker-compose up -d
```

You can also specify the number of containers to run for your build agents

```bash
docker-compose up -d --scale teamcity-agent=3
```

After initialisation Web Interface will be available on `http://yourdockerhost:8111/`

### Setup DB

- Open `http://yourdockerhost:8111/`
- Set PostgreSQL as database type
- In terminal, do
 ```bash
 sudo su # enter password when prompted
 cd /srv/teamcity/data/lib/jdbc
 wget https://jdbc.postgresql.org/download/postgresql-42.2.1.jar
 ```
- Go back to `http://yourdockerhost:8111/` and click «Refresh JDBC drivers»
- Configure DB connection
- Authorize your Agents
- Done, [TeamCity](TeamCity) is ready to work.

## Scaling

Scaling you workers (agents) supported as well. Just use `docker-compose scale` command:

```bash
docker-compose scale teamcity-agent=3
```

Keep in mind: **currently, agents are stateless**

## Backup / restore

You may use JetBrains way to [backup](backup) or [restore](restore) your server

## Update

If you see a notice that a new version is available, you may update your TeamCity that way:

```bash
# build new version
docker-compose build --pull --no-cache

# stop and remove old containers
docker-compose stop
docker-compose rm

# create and up new containers
docker-compose up -d
```

After an update, you need to reauthorize your agents.

### Updating maintenance

Sometimes, during update you may get «maintenance is required» message instead of login page. It's ok! To login in a maintenance mode you need to enter an authentication token. You may find it in the logs:
`docker-compose logs -f`

Try to find something like this:

```bash
[TeamCity] Administrator can login from web UI using authentication token: 755994969038184734
```

## Contributing

Bug reports, bug fixes and new features are always welcome.
Please open issues and submit pull requests for any new code.

[TeamCity]: https://www.jetbrains.com/teamcity/
[backup]: https://confluence.jetbrains.com/display/TCD10/TeamCity+Data+Backup
[restore]: https://confluence.jetbrains.com/display/TCD10/Restoring+TeamCity+Data+from+Backup
[recommendations]: https://confluence.jetbrains.com/pages/viewpage.action?pageId=74847395#HowTo...-ConfigureNewlyInstalledPostgreSQLServer