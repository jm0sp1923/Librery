<?php

use App\Http\Controllers\BookController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\EditorialController;
use App\Http\Controllers\LoanController;
use App\Http\Controllers\MemberController;
use App\Models\Editorial;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResource('book', BookController::class);

Route::apiResource('category', CategoryController::class);

Route::apiResource('editorial', EditorialController::class);

Route::apiResource('loan', LoanController::class);

Route::apiResource('member', MemberController::class);