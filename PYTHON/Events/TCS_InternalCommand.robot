*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 129 27 210 40 47 193 188 160 31 147 60 89 92 116 85 234 32 136 5 242 7 128 157 87 65 211 26 242 56 119 83 133 27 183 186 171 28 54 70 214 82 149 93 183 82 131 80 32 11 112 83 79 226 163 216 234 158 244 174 149 161 194 235 120 60 235 184 25 25 221 110 8 131 194 188 89 75 243 210 157 147 189 168 38 18 254 55 224 10 202 56 101 23 87 99 177 107 141 87 195 135 14 91 32 173 155 150 59 66 223 107 208 252 19 141 38 246 139 35 255 112 135 254 66 77 135 12 12 241 76 239 142 205 191 201 206 19 77 236 219 93 145 152 169 117 207 250 10 45 208 19 20 128 89 55 159 26 188 153 120 201 140 40 78 62 160 244 88 45 237 158 235 76 226 142 186 108 236 19 85 90 195 8 146 213 39 164 220 209 50 217 99 20 20 152 97 161 156 254 37 85 131 240 118 188 194 244 142 213 103 200 23 88 20 46 248 51 111 103 65 226 190 152 33 221 104 84 115 114 3 163 166 244 99 222 78 72 233 89 195 72 4 99 89 155 109 44 180 19 118 10 208 126 238 115 79 254 37 244 162 122 189 143 150 103 134 177 50 248 8 240 58 18 77 203 68 27 101 54 218 156 91 201 107 150 219 43 103 165 119 211 133 116 194 246 93 198 74 46 146 227 49 25 238 69 171 229 140 184 181 22 238 228 141 205 3 222 160 118 10 33 10 146 160 81 165 133 38 79 47 43 222 186 56 225 107 85 114 237 65 182 185 26 164 121 30 47 63 243 25 25 198 249 51 167 219 7 45 189 67 37 170 194 227 104 77 128 26 175 195 130 226 53 209 242 204 144 164 1 248 32 98 63 107 81 138 199 181 163 201 114 118 85 221 34 54 1 206 98 210 37 108 224 194 124 13 128 220 178 17 30 171 35 146 199 30 102 134 177 77 212 9 181 51 20 103 193 178 252 27 13 76 220 232 134 252 121 181 243 138 161 185 195 164 112 55 106 35 237 254 238 4 37 242 29 233 215 69 185 210 180 252 47 241 40 143 253 128 87 184 93 203 208 92 3 177 152 164 59 175 23 194 209 214 87 139 220 175 156 167 92 39 127 92 51 152 63 15 177 85 214 22 5 61 4 9 143 179 54 167 7 61 172 192 191 209 175 215 181 176 239 124 118 79 122 121 52 243 24 49 151 11 28 200 31 212 32 123 4 34 219 197 47 208 47 142 75 179 34 206 247 6 218 73 68 192 232 72 219 142 143 164 60 50 200 113 167 242 83 183 111 99 125 93 243 109 230 41 111 171 185 204 133 97 116 215 214 219 160 130 193 236 170 161 216 193 134 95 139 225 135 91 73 65 190 4 156 54 190 230 198 154 110 2 240 156 205 38 67 223 107 200 33 173 131 164 175 142 237 152 141 242 169 84 244 131 80 152 132 226 34 13 238 200 135 97 242 164 40 221 230 204 197 228 246 163 120 7 194 102 217 119 40 119 226 118 197 18 75 18 227 20 249 15 121 198 112 41 7 137 186 222 221 176 172 204 237 164 122 121 5 185 232 30 246 96 217 50 163 121 224 209 96 181 57 248 63 82 188 167 248 244 145 155 201 243 180 6 113 52 249 130 118 43 81 168 68 100 171 36 133 133 111 187 137 11 49 249 148 229 141 169 190 84 144 28 95 50 115 47 62 67 7 196 19 130 57 101 88 143 245 150 53 48 74 55 167 172 60 29 166 135 228 251 72 58 73 0 221 175 194 249 165 5 45 2 133 49 230 1 130 208 233 33 161 90 220 188 228 72 45 88 244 115 255 53 147 144 23 141 170 3 215 135 27 163 52 243 115 237 250 227 126 221 140 84 175 38 19 164 65 238 187 206 161 142 239 217 165 201 136 3 252 84 25 53 97 171 238 189 221 185 89 52 22 111 46 208 93 41 68 211 180 122 144 110 143 120 74 183 201 214 181 238 62 130 249 14 163 252 173 39 2 121 43 245 18 165 216 6 86 3 40 191 248 25 111 112 3 111 17 134 112 152 221 252 49 118 57 48 163 237 255 65 217 64 49 149 43 57 26 132 234 254 61 133 194 213 190 144 44 100 213 35 213 76 69 1 159 100 40 165 166 226 228 91 154 40 155 82 120 139 254 134 79 12 129 199 118 81 143 114 173 25 73 42 133 40 254 172 230 70 52 65 129 6 140 226 52 16 148 212 46 222 76 188 6 200 88 171 179 218 242 193 0 85 123 253 70 197 -441042309
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
