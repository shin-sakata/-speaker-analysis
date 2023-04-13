import ffmpeg
import os


# データファイルの名前を受け取って、絶対パスを返す
def data_path(filename: str) -> str:
    return os.path.join(os.path.dirname(__file__), "..", "..", "data", filename)


# ファイルを読み込んで、mp3に変換してoutputに書き出す
def to_mp3(filename: str, output: str) -> None:
    stream = ffmpeg.input(data_path(filename))
    # pyannote.audioでは最初の0.5秒間は扱わないので、音声データの先頭に0.5秒の無音を追加する
    stream = ffmpeg.filter(stream, "adelay", "1000|1000")
    stream = ffmpeg.output(stream, data_path(
        output), format="mp3", b="64k", ac="1")
    ffmpeg.run(stream)
