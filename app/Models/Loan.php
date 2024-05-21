<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Loan extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table = 'loan';
    protected $fillable = [
        'member_id',
        'book_id',
        'loan_date',
        'return_date'
    ];

    public function book(){
        return $this->belongsTo(Book::class);
    }

    
    public function member(){
        return $this->belongsTo(Member::class);
    }


}
