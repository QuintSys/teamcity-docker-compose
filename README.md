# teamcity-docker-compose
Compose to create working [TeamCity](https://www.jetbrains.com/teamcity/) server with PostgreSQL and Agents


# How to use

Clone this repository or download the zip.

```
git clone https://github.com/QuintSys/teamcity-docker-compose.git
```

## Configuration

Set your Postgres username and password variables in `env.example` and rename `env.example` to `.env`

Don't push `.env` file in public repositories!

PostgreSQL is already configured according to the
JetBrains [recommendations](https://confluence.jetbrains.com/pages/viewpage.action?pageId=74847395#HowTo...-ConfigureNewlyInstalledPostgreSQLServer)

## Build and setup

Next, build the images:

```
cd teamcity-docker-compose
docker-compose build
```

Now you can start up the service and continue configuring settings in Web Interface:

```
docker-compose up
```

After initialisation Web Interface will be available on `http://yourdockerhost:8111/`


### Setup DB

Open `http://yourdockerhost:8111/`

- Set PostgreSQL as database type and click «Refresh JDBC drivers»
- Configure DB connection
- Authorize your Agents
- Done, TeamCity is ready to work.

## Scaling

Scaling you workers (agents) supported as well. Just use `docker-compose scale` command:

```
docker-compose scale teamcity-agent=3
```
**Keep in mind: currently, agents are stateless**


## Backup / restore

You may use JetBrains way to [backup](https://confluence.jetbrains.com/display/TCD10/TeamCity+Data+Backup) 
or [restore](https://confluence.jetbrains.com/display/TCD10/Restoring+TeamCity+Data+from+Backup) your server

## Update

If you see a notice that a new version is available, you may update your TeamCity that way:

```
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

Sometimes, during update you may get «maintenance is required» message instead of login page. 
It's ok! To login in a maintenance mode you need to enter an authentication token. You may find it in the logs:
`docker-compose logs -f`

Try to find something like this:

```
[TeamCity] Administrator can login from web UI using authentication token: 755994969038184734
```

## Contributing

Bug reports, bug fixes and new features are always welcome.
Please open issues and submit pull requests for any new code.