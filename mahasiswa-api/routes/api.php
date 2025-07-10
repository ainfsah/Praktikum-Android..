<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\MahasiswaController;
use App\Http\Controllers\MataKuliahController;
use App\Http\Controllers\JadwalController;

Route::apiResource('mahasiswa', MahasiswaController::class);
Route::apiResource('mata-kuliah', MataKuliahController::class);

Route::get('/jadwal', [JadwalController::class, 'index']);
Route::post('/jadwal', [JadwalController::class, 'store']);
Route::get('/jadwal/{id}', [JadwalController::class, 'show']);
Route::put('/jadwal/{id}', [JadwalController::class, 'update']);
Route::delete('/jadwal/{id}', [JadwalController::class, 'destroy']);
