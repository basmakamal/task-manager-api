<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\DashboardService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

/**
 * @group Dashboard
 */
class DashboardController extends Controller
{
    public function __construct(protected DashboardService $dashboardService)
    {
    }

    /**
     * Dashboard stats
     *
     * Returns project and task counters for the authenticated user.
     */
    public function __invoke(Request $request): JsonResponse
    {
        return response()->json([
            'data' => $this->dashboardService->statsFor($request->user()),
        ]);
    }
}
