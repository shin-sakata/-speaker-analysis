from src.env import env
import openai


def new_openai_client(OPENAI_API_KEY, OPENAI_ORG_ID):
    openai.api_key = OPENAI_API_KEY
    openai.organization = OPENAI_ORG_ID
    return openai
