from pyannote.audio import Pipeline
from lib.data import data_path
from lib.env import env

pipeline = Pipeline.from_pretrained(
    "pyannote/speaker_diarization", use_auth_token=env.PYANNOTE_AUTH_TOKEN)
diarization = pipeline(data_path("data.mp3"))

print(diarization)
