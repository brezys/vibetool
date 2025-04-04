# -*- mode: python ; coding: utf-8 -*-
from PyInstaller.utils.hooks import collect_all
import os

block_cipher = None

# Collect all necessary files from vosk
vosk_datas, vosk_binaries, vosk_hiddenimports = collect_all('vosk')

# Define the model directory - it will be copied separately
model_dir = os.path.abspath('vosk-model-small-en-us-0.15')

a = Analysis(
    ['app.py'],
    pathex=[],
    binaries=vosk_binaries,
    datas=vosk_datas,  # Include vosk data files but handle model separately
    hiddenimports=vosk_hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='VibeCoding',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,  # Set to False for normal use
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='VibeCoding.ico',
) 