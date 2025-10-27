from decouple import Config, RepositoryEnv, config
import pathlib
from functools import lru_cache

ENV_PATH = pathlib.Path(__file__).parent.parent / ".env"    

@lru_cache()
def get_config():
    """Load environment variables from a .env file."""
    if ENV_PATH.exists():
        return Config(RepositoryEnv(str(ENV_PATH)))
    
    else:
        return config

config = get_config()